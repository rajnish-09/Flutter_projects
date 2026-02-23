import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/chat/chat_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_event.dart';
import 'package:whatsapp_clone/bloc/group/group_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_state.dart';

class BuildGroupList extends StatelessWidget {
  const BuildGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        if (state is GroupLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GroupLoaded) {
          final groups = state.groups;

          if (groups.isEmpty) {
            return Center(child: Text("No groups found"));
          }
          return ListView.separated(
            itemCount: groups.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              final group = groups[index];
              // final otherUserId = group.participants
              //     .firstWhere(
              //       (uid) => uid != currentUserId,
              //       orElse: () => currentUserId,
              //     );

              return Slidable(
                key: ValueKey(groups[index].groupId),
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<ChatBloc>().add(
                          DeleteChat(chatId: group.groupId!),
                        );
                        // print(chat.chatId);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    // Navigate to group chat screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) =>
                    //         GroupChatScreen(group: group),
                    //   ),
                    // );
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    // You can show group image if available or default icon
                    // backgroundImage: group.imagePath != null
                    //     ? NetworkImage(group.imagePath!)
                    //     : const AssetImage(
                    //             'assets/images/group_icon.png',
                    //           )
                    //           as ImageProvider,
                    backgroundImage:
                        AssetImage('assets/images/default_group_icon.png')
                            as ImageProvider,
                  ),
                  title: Text(
                    group.groupName,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    group.lastMsg,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              );
            },
          );
        }
        return Center(child: Text("Error loading groups"));
      },
    );
  }
}
