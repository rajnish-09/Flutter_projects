import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String? groupId;
  final String groupName;
  final List<String> members;
  final String createdBy;
  final String lastMsg;
  final DateTime? lastMessageTime;

  GroupModel({
    this.groupId,
    required this.groupName,
    required this.members,
    required this.createdBy,
    this.lastMsg = '',
    this.lastMessageTime,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json, String id) {
    return GroupModel(
      groupId: id,
      groupName: json['groupName'] ?? '',
      lastMsg: json['lastMsg'],
      lastMessageTime: json['lastMessageTime'] != null
          ? (json['lastMessageTime'] as Timestamp).toDate()
          : null,
      members: Set<String>.from(json['members'] ?? []).toList(),
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() => {
    'groupName': groupName,
    'members': members,
    'createdBy': createdBy,
    'lastMsg': lastMsg,
    'lastMessageTime': lastMessageTime,
  };
}
