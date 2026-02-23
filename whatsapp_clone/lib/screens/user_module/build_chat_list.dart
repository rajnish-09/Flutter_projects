import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/chat/chat_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_event.dart';
import 'package:whatsapp_clone/bloc/chat/chat_state.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/user_module/chat_detail_screen.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/utils/crypto_helper.dart';

class BuildChatList extends StatefulWidget {
  final String currentUserId;
  final Function showModalSheet;
  const BuildChatList({
    super.key,
    required this.currentUserId,
    required this.showModalSheet,
  });

  @override
  State<BuildChatList> createState() => _BuildChatListState();
}

class _BuildChatListState extends State<BuildChatList> {
  Map<String, UserModel> usersMap = {};

  void loadAllUsers() async {
    final users = await FirebaseService().getUsers(); // fetch all users once
    setState(() {
      usersMap = {for (var u in users) u.uid!: u};
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ChatLoaded) {
          final chats = state.chats;

          if (chats.isEmpty) {
            return Center(child: Text("No chats found"));
          }
          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              final chat = chats[index];
              final otherUserId = chat.participants.firstWhere(
                (uid) => uid != widget.currentUserId,
                orElse: () => widget.currentUserId,
              );
              final otherUser = usersMap[otherUserId];
              return Slidable(
                key: ValueKey(chats[index].chatId),
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<ChatBloc>().add(
                          DeleteChat(chatId: chat.chatId!),
                        );
                        // print(chat.chatId);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onLongPress: () {
                    // showAllUserBottomSheet(otherUserId);
                    widget.showModalSheet(otherUserId);
                  },
                  child: ListTile(
                    onTap: () async {
                      // final otherUser = await FirebaseService().getChatUser(
                      //   otherUserId,
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(user: otherUser!),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/male_icon.png')
                              as ImageProvider,
                    ),
                    title: Text(
                      otherUser?.name ?? 'Unknown',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      CryptoHelper.decrypt(chat.lastMsg),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(child: Text("Error loading chats"));
      },
    );
  }
}
