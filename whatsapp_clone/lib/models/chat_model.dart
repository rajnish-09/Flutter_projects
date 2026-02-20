class ChatModel {
  final String? chatId;
  final List<String> participants;
  // final String lastMsg;
  //last msg time

  ChatModel({this.chatId, required this.participants});

  factory ChatModel.fromJson(Map<String, dynamic> json, String id) {
    return ChatModel(
      chatId: id,
      participants: List<String>.from(json['participants'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {'participants': participants};
}
