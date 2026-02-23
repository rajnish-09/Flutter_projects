import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:whatsapp_clone/bloc/message/message_bloc.dart';
import 'package:whatsapp_clone/bloc/message/message_event.dart';
import 'package:whatsapp_clone/bloc/message/message_state.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/utils/crypto_helper.dart';

class ChatDetailScreen extends StatefulWidget {
  final UserModel user;
  const ChatDetailScreen({super.key, required this.user});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final messageController = TextEditingController();
  String chatId = '';
  bool isSending = false;

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

  void _showMessageMenu(
    BuildContext context,
    Offset position,
    MessageModel message,
  ) async {
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: const [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Text('Delete'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'copy',
          child: Row(
            children: const [
              Icon(Icons.copy),
              SizedBox(width: 10),
              Text('Copy'),
            ],
          ),
        ),
      ],
    );

    if (selected == 'delete') {
      await FirebaseService().deleteMessage(chatId, message.messageId!);
    }

    if (selected == 'copy') {
      Clipboard.setData(ClipboardData(text: message.message));
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text('Message copied')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/male_icon.png'),
            ),
            SizedBox(width: 10),
            Text(widget.user.name),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      return Expanded(
                        child: Center(child: Text("No message yet. Say hi")),
                      );
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
                          String formattedTime = '';
                          if (msg.timestamp != null) {
                            formattedTime = DateFormat(
                              'hh:mm a',
                            ).format(msg.timestamp!);
                          } else {
                            formattedTime = '...';
                          }
                          return GestureDetector(
                            onLongPressStart: (details) {
                              _showMessageMenu(
                                context,
                                details.globalPosition,
                                msg,
                              );
                            },
                            child: Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6,
                                ),
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
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      msg.message,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      formattedTime,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
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
                      textCapitalization: TextCapitalization.sentences,
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
                      return (value.text.isNotEmpty || isSending)
                          ? IconButton(
                              onPressed: isSending
                                  ? null
                                  : () {
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user == null) return;
                                      final uid1 = user.uid;
                                      final uid2 = widget.user.uid;
                                      final chatId = generateChatId(
                                        uid1,
                                        uid2!,
                                      );
                                      setState(() {
                                        isSending = true;
                                      });
                                      context.read<MessageBloc>().add(
                                        SendMessage(
                                          chat: ChatModel(
                                            participants: [uid1, uid2],
                                          ),
                                          msg: MessageModel(
                                            senderId: uid1,
                                            message: messageController.text
                                                .trim(),
                                          ),
                                          chatId: chatId,
                                        ),
                                      );

                                      messageController.clear();
                                      Future.delayed(
                                        const Duration(milliseconds: 500),
                                        () {
                                          if (mounted) {
                                            setState(() => isSending = false);
                                          }
                                        },
                                      );
                                      
                                    },
                              icon: isSending
                                  ? Padding(
                                      padding: EdgeInsets.all(5),
                                      child: CircularProgressIndicator(),
                                    )
                                  : Icon(Icons.send),
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
