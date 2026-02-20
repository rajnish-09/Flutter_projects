import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/widgets/show_snackbar.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final whatsappUserCollection = FirebaseFirestore.instance.collection(
    'whatsappUser',
  );
  final chatCollection = FirebaseFirestore.instance.collection('chats');
  // final messageCollection = FirebaseFirestore.instance.collection('messages');

  Future<String> createUsers({
    required UserModel userData,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: userData.email,
      password: password,
    );
    String uid = userCredential.user!.uid;
    whatsappUserCollection.doc(uid).set(userData.toJson());
    return uid;
  }

  Future<void> loginUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  Future<List<UserModel>> getUsers() async {
    final response = await whatsappUserCollection.get();
    return response.docs
        .map((user) => UserModel.fromJson(user.data(), user.id))
        .toList();
  }

  //---------------------MESSAGE-----------------------------------------------

  Future<void> sendMessage(
    MessageModel msg,
    String chatId,
    ChatModel chat,
  ) async {
    final chatRef = chatCollection.doc(chatId);
    await chatRef.set(chat.toJson(), SetOptions(merge: true));
    await chatRef.collection('messages').add(msg.toJson());

    // 3️⃣ Update last message info
    await chatRef.update({
      'lastMsg': msg.message,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return chatCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((msg) => MessageModel.fromJson(msg.data()))
              .toList(),
        );
  }

  Stream<List<ChatModel>> getChats(String uid) {
    return chatCollection
        .where('participants', arrayContains: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((chat) => ChatModel.fromJson(chat.data(), chat.id))
              .toList(),
        );
  }
}
