import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servup/models/user_model.dart';

class FirebaseService {
  final servUpUsers = FirebaseFirestore.instance.collection("ServupUsers");

  // Signup Users
  Future<void> signupUsers(UserModel userData) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: userData.email,
          password: userData.password!,
        );
    String uid = userCredential.user!.uid;
    servUpUsers.doc(uid).set(userData.toJson());
  }

  // Login Users
  Future<void> loginUsers({required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
