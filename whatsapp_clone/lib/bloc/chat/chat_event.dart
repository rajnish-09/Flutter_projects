abstract class ChatEvent {}

class LoadChat extends ChatEvent {
  final String uid;
  LoadChat({required this.uid});
}

class DeleteChat extends ChatEvent {
  final String chatId;
  DeleteChat({required this.chatId});
}
