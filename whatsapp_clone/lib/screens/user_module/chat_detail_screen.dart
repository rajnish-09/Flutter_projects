import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/message/message_bloc.dart';
import 'package:whatsapp_clone/bloc/message/message_event.dart';
import 'package:whatsapp_clone/bloc/message/message_state.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final UserModel user;
  const ChatDetailScreen({super.key, required this.user});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final messageController = TextEditingController();
  String chatId = '';

  String generateChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && widget.user.uid != null) {
      chatId = generateChatId(currentUser.uid, widget.user.uid!);
    }
    context.read<MessageBloc>().add(LoadMessages(chatId: chatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/male_icon.png'),
            ),
            SizedBox(width: 10),
            Text(widget.user.name),
          ],
        ),
        actions: [Icon(Icons.call)],
        actionsPadding: EdgeInsets.only(right: 15),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   padding: EdgeInsets.all(5),
              //   width: MediaQuery.of(context).size.width * 0.5,
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 245, 245, 245),
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Text("datsdfklsdjfklsdjlkfjsdlkfjl;ksdjflksdjlfkja"),
              // ),

              // Spacer(),
              BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is MessageLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is MessageError) {
                    return Center(child: Text(state.error));
                  }
                  if (state is MessageLoaded) {
                    bool isMe;
                    final message = state.msgs;
                    if (message.isEmpty) {
                      return Center(child: Text("No message yet. Say hi"));
                    }
                    return Expanded(
                      child: ListView.separated(
                        reverse: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemCount: message.length,
                        itemBuilder: (context, index) {
                          final msg = state.msgs[index];
                          final currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser == null) return null;
                          if (msg.senderId == currentUser.uid) {
                            isMe = true;
                          } else {
                            isMe = false;
                          }
                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Colors.blue[100]
                                    : Colors.grey[200],
                                borderRadius: isMe
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        topRight: Radius.circular(0),
                                        bottomRight: Radius.circular(20),
                                      )
                                    : BorderRadius.only(
                                        topLeft: Radius.zero,
                                        bottomLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                              ),
                              child: Text(
                                msg.message,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Text("Error");
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser == null) return;
                    },
                    icon: Icon(Icons.add),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        suffixIcon: Icon(Icons.emoji_emotions),
                        filled: true,
                        fillColor: const Color.fromARGB(141, 255, 255, 255),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      maxLines: 4,
                      minLines: 1,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: messageController,
                    builder: (context, TextEditingValue value, _) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user == null) return;
                                final uid1 = user.uid;
                                final uid2 = widget.user.uid;
                                final chatId = generateChatId(uid1, uid2!);
                                context.read<MessageBloc>().add(
                                  SendMessage(
                                    chat: ChatModel(participants: [uid1, uid2]),
                                    msg: MessageModel(
                                      senderId: uid1,
                                      message: messageController.text.trim(),
                                    ),
                                    chatId: chatId,
                                  ),
                                );
                                messageController.clear();
                              },
                              icon: Icon(Icons.send),
                            )
                          : SizedBox();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Expanded(
//                       child: TextFormField(
//                         controller: searchController,
//                         decoration: InputDecoration(
//                           hintText: 'Message...',
//                           hintStyle: TextStyle(color: Colors.grey.shade500),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide(color: Colors.transparent),
//                           ),
//                           filled: true,
//                           fillColor: const Color.fromARGB(166, 238, 238, 238),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.grey.shade500,
//                           ),
//                           suffix: IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.emoji_emotions),
//                           ),
//                         ),
//                       ),
//                     ),