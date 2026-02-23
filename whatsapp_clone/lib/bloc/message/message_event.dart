import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';

abstract class MessageEvent {}

class SendMessage extends MessageEvent {
  final String chatId;
  final MessageModel msg;
  final ChatModel chat;
  final bool isGroup;
  SendMessage({
    required this.chat,
    required this.msg,
    required this.chatId,
    required this.isGroup,
  });
}

class LoadMessages extends MessageEvent {
  final String chatId;
  final bool isGroup;
  LoadMessages({required this.chatId, required this.isGroup});
}

class MessagesUpdated extends MessageEvent {
  final List<MessageModel> msgs;
  MessagesUpdated(this.msgs);
}
