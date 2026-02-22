import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/chat/chat_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_event.dart';
import 'package:whatsapp_clone/bloc/chat/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/utils/crypto_helper.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    context.read<ChatBloc>().add(LoadChat(uid: user.uid));
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Chats",
                style: GoogleFonts.raleway(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search chats',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(166, 238, 238, 238),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
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
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          final otherUserId = chat.participants.firstWhere(
                            (uid) => uid != currentUserId,
                            orElse: () => currentUserId,
                          );

                          return FutureBuilder<UserModel>(
                            future: FirebaseService().getChatUser(otherUserId),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/male_icon.png',
                                    ),
                                  ),
                                  title: Text("Loading..."),
                                );
                              }

                              final otherUser = snapshot.data!;
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ChatDetailScreen(user: otherUser),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: otherUser.imagePath != null
                                      ? NetworkImage(otherUser.imagePath!)
                                      : AssetImage(
                                              'assets/images/male_icon.png',
                                            )
                                            as ImageProvider,
                                ),
                                title: Text(
                                  otherUser.name,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  CryptoHelper.decrypt(chat.lastMsg),
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return Center(child: Text("Error loading chats"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
