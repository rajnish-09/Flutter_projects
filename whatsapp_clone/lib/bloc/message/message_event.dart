import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';

abstract class MessageEvent {}

class SendMessage extends MessageEvent {
  final String chatId;
  final MessageModel msg;
  final ChatModel chat;
  SendMessage({required this.chat, required this.msg, required this.chatId});
}
