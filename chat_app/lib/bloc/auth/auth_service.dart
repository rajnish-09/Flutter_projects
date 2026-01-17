import 'package:chat_app/ui/otp_screen.dart';
import 'package:chat_app/utils/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService {
  final kurakaniUserCollection = FirebaseFirestore.instance.collection(
    'kurakaniUserCollection',
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerNewUser(BuildContext context, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        showSnackBar(context, e.toString());
      },
      codeSent: ((String verificationId, int? resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(verificationId: verificationId),
          ),
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
