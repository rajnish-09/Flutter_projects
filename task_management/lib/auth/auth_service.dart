import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final taskUsersCollection = FirebaseFirestore.instance.collection(
    'taskUsers',
  );
  Future<String> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      await taskUsersCollection.doc().set({
        'uid': uid,
        'name': name,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
      });
      return uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user!.uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
