import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? chatId;
  final List<String> participants;
  final String lastMsg;
  final DateTime? lastMessageTime;

  ChatModel({
    this.chatId,
    required this.participants,
    this.lastMsg = '',
    this.lastMessageTime,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json, String id) {
    return ChatModel(
      chatId: id,
      participants: List<String>.from(json['participants'] ?? []),
      lastMsg: json['lastMsg'] ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? (json['lastMessageTime'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'participants': participants,
    'lastMsg': lastMsg,
    'lastMessageTime': lastMessageTime ?? FieldValue.serverTimestamp(),
  };
}
