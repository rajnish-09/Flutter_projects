import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/chat/chat_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_event.dart';
import 'package:whatsapp_clone/bloc/chat/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/bloc/users/user_bloc.dart';
import 'package:whatsapp_clone/bloc/users/user_event.dart';
import 'package:whatsapp_clone/bloc/users/user_state.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/utils/crypto_helper.dart';
import 'package:whatsapp_clone/widgets/show_snackbar.dart';
import 'package:whatsapp_clone/widgets/show_toast.dart';
import 'chat_detail_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final searchController = TextEditingController();
  String filteredSearch = '';
  Set<String> selectedUserIds = {};

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    context.read<ChatBloc>().add(LoadChat(uid: user.uid));
    context.read<UserBloc>().add(LoadUsers());
  }

  void showAllUserBottomSheet(String selectedPersonUid) {
    final currentUser = FirebaseAuth.instance.currentUser;
    selectedUserIds.add(currentUser!.uid);
    selectedUserIds.add(selectedPersonUid);
    String groupError = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: StatefulBuilder(
              builder: (context, bottomSetState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Add members to group",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is UserError) {
                          return Center(child: Text(state.msg));
                        }
                        if (state is UserLoaded) {
                          final users = state.users;
                          return Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final user = users[index];
                                final isCurrentUser =
                                    user.uid == currentUser.uid;
                                final isSelectedUser =
                                    user.uid == selectedPersonUid;
                                final isSelected = selectedUserIds.contains(
                                  user.uid,
                                );
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        'assets/images/male_icon.png',
                                      ),
                                    ),
                                    Expanded(
                                      child: CheckboxListTile(
                                        value: isSelected,
                                        title: Text(user.name),
                                        subtitle: Text(user.email),
                                        onChanged:
                                            (isCurrentUser || isSelectedUser)
                                            ? null
                                            : (value) {
                                                bottomSetState(() {
                                                  if (value == true) {
                                                    selectedUserIds.add(
                                                      user.uid!,
                                                    );
                                                  } else {
                                                    selectedUserIds.remove(
                                                      user.uid,
                                                    );
                                                  }
                                                  groupError = '';
                                                });
                                              },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10);
                              },
                              itemCount: users.length,
                            ),
                          );
                        }
                        return Center(child: Text("Error loading users."));
                      },
                    ),
                    Text(groupError, style: TextStyle(color: Colors.red)),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedUserIds.length <= 2) {
                          bottomSetState(() {
                            groupError = 'Required more than 2 participants';
                          });
                        }
                      },
                      child: Text("Create"),
                    ),
                  ],
                );
              },
              // child:
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              context.read<ChatBloc>().add(LoadChat(uid: user.uid));
            }
            return await Future.delayed(Duration(milliseconds: 100));
          },
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
                  onChanged: (value) {
                    setState(() {
                      filteredSearch = value;
                    });
                  },
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
                      if (state is ChatDeleted) {
                        // showSnackBar(context, state.msg, Colors.green);
                        showToastWidget(state.msg, Colors.green);
                      }

                      if (state is ChatLoaded) {
                        final chats = state.chats;

                        if (chats.isEmpty) {
                          return Center(child: Text("No chats found"));
                        }
                        // if (searchController.text.isNotEmpty) {
                        //   chats = state.chats.where((chat){

                        //     return chat.chatId
                        //   })
                        // }
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

                            return Slidable(
                              key: ValueKey(chats[index]),
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
                                    // label: 'Delete',
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onLongPress: () {
                                  // print(otherUserId);
                                  showAllUserBottomSheet(otherUserId);
                                },
                                child: FutureBuilder<UserModel>(
                                  future: FirebaseService().getChatUser(
                                    otherUserId,
                                  ),
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
                                            builder: (_) => ChatDetailScreen(
                                              user: otherUser,
                                            ),
                                          ),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            otherUser.imagePath != null
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
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
      ),
    );
  }
}
