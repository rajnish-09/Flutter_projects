import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String message;
  final DateTime? timestamp;

  MessageModel({required this.senderId, required this.message, this.timestamp});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      message: json['message'],
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'message': message,
    'timestamp': FieldValue.serverTimestamp(),
  };
}
