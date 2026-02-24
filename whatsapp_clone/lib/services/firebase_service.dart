import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/models/group_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/utils/crypto_helper.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final whatsappUserCollection = FirebaseFirestore.instance.collection(
    'whatsappUser',
  );
  final chatCollection = FirebaseFirestore.instance.collection('chats');
  final groupCollection = FirebaseFirestore.instance.collection('groups');

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

  Future<UserModel> getChatUser(String uid) async {
    final response = await whatsappUserCollection.doc(uid).get();
    return UserModel.fromJson(
      response.data() as Map<String, dynamic>,
      response.id,
    );
  }

  Future<UserModel> getPersonalDetail() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final response = await whatsappUserCollection.doc(user!.uid).get();
    return UserModel.fromJson(
      response.data() as Map<String, dynamic>,
      response.id,
    );
  }

  Future<void> saveFCMToken() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? token = await FirebaseMessaging.instance.getToken();

    if (user == null) return;
    await FirebaseFirestore.instance
        .collection('whatsappUser')
        .doc(user.uid)
        .update({'fcmToken': token});
  }

  Future<void> updateUserData(UserModel updatedUserData) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await whatsappUserCollection
        .doc(user!.uid)
        .update(updatedUserData.toJson());
  }

  //---------------------MESSAGE-----------------------------------------------

  Future<void> sendMessage(
    MessageModel msg,
    String chatId,
    ChatModel chat,
    bool isGroup,
  ) async {
    if (isGroup) {
      final groupRef = groupCollection.doc(chatId);
      final encryptedMsg = msg.copyWith(
        message: CryptoHelper.encrypt(msg.message),
      );
      await groupRef.set(chat.toJson(), SetOptions(merge: true));
      await groupRef.collection('messages').add(encryptedMsg.toJson());

      // 3️⃣ Update last message info
      await groupRef.update({
        'lastMsg': encryptedMsg.message,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    } else {
      final chatRef = chatCollection.doc(chatId);
      final encryptedMsg = msg.copyWith(
        message: CryptoHelper.encrypt(msg.message),
      );
      await chatRef.set(chat.toJson(), SetOptions(merge: true));
      await chatRef.collection('messages').add(encryptedMsg.toJson());

      // 3️⃣ Update last message info
      await chatRef.update({
        'lastMsg': encryptedMsg.message,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<List<MessageModel>> getMessages(String chatId, bool isGroup) {
    if (isGroup) {
      return groupCollection
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              final encryptedMessage = data['message'] ?? '';
              return MessageModel.fromJson({
                ...data,
                'message': CryptoHelper.decrypt(encryptedMessage),
              }, doc.id);
            }).toList(),
          );
    }
    return chatCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            final encryptedMessage = data['message'] ?? '';
            return MessageModel.fromJson({
              ...data,
              'message': CryptoHelper.decrypt(encryptedMessage),
            }, doc.id);
          }).toList(),
        );
  }

  Future<void> deleteMessage(
    String chatId,
    String messageId,
    bool isGroup,
  ) async {
    if (isGroup) {
      await groupCollection
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
      return;
    }
    await chatCollection
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  //--------------------------------CHATS----------------------------
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

  Future<void> deleteChat(String chatId) async {
    await chatCollection.doc(chatId).delete();
  }

  //--------------------------------GROUP ----------------------------
  Future<void> createGroup(GroupModel group) async {
    await groupCollection.add(group.toJson());
  }

  Stream<List<GroupModel>> getGroup(String uid) {
    return groupCollection
        .where('members', arrayContains: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((e) => GroupModel.fromJson(e.data(), e.id))
              .toList(),
        );
  }
}
