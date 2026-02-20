import 'package:whatsapp_clone/models/chat_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatModel> chats;
  ChatLoaded({required this.chats});
}

class ChatError extends ChatState {
  final String error;
  ChatError({required this.error});
}
