abstract class ChatEvent {}

class LoadChat extends ChatEvent {
  final String uid;
  LoadChat({required this.uid});
}
