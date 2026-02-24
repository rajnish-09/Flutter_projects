import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/chat/chat_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_event.dart';
import 'package:whatsapp_clone/bloc/chat/chat_state.dart';
import 'package:whatsapp_clone/bloc/group/group_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_event.dart';
import 'package:whatsapp_clone/bloc/group/group_state.dart';
import 'package:whatsapp_clone/bloc/users/user_bloc.dart';
import 'package:whatsapp_clone/bloc/users/user_event.dart';
import 'package:whatsapp_clone/bloc/users/user_state.dart';
import 'package:whatsapp_clone/models/group_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/user_module/build_chat_list.dart';
import 'package:whatsapp_clone/screens/user_module/build_group_list.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/utils/crypto_helper.dart';
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
  final groupNameController = TextEditingController();
  String filteredSearch = '';
  Set<String> selectedUserIds = {};
  final _formKey = GlobalKey<FormState>();
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    context.read<ChatBloc>().add(LoadChat(uid: user.uid));
    context.read<UserBloc>().add(LoadUsers());
    context.read<GroupBloc>().add(LoadGroup(uid: user.uid));
    saveFCMToken();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    groupNameController.dispose();
  }

  void saveFCMToken() async {
    await FirebaseService().saveFCMToken();
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
                return Form(
                  key: _formKey,
                  child: Column(
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
                      TextFormField(
                        controller: groupNameController,
                        onChanged: (value) {
                          setState(() {
                            filteredSearch = value;
                          });
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Enter group name',
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
                          prefixIcon: Icon(
                            Icons.group,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Group name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
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
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (selectedUserIds.length <= 2) {
                              bottomSetState(() {
                                groupError =
                                    'Required more than 2 participants';
                              });
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              final group = GroupModel(
                                groupName: groupNameController.text.trim(),
                                members: selectedUserIds.toList(),
                                createdBy: currentUser.uid,
                              );
                              context.read<GroupBloc>().add(
                                CreateGroup(group: group),
                              );
                              Navigator.pop(context);
                              groupNameController.clear();
                            }
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedTab == 0
                                ? Colors.blue
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Chats",
                              style: TextStyle(
                                color: selectedTab == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedTab == 1
                                ? Colors.blue
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Groups",
                              style: TextStyle(
                                color: selectedTab == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: selectedTab == 0
                      ? BuildChatList(
                          currentUserId: currentUserId,
                          showModalSheet: showAllUserBottomSheet,
                        )
                      : BuildGroupList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
