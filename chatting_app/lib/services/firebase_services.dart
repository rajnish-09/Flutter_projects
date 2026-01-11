import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final kurakaniUserCollections = FirebaseFirestore.instance.collection(
    'kurakaniUsers',
  );
  Future<String> registerNewUser(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return response.user?.uid ?? '';
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<String> loginUser(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user?.uid ?? '';
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
