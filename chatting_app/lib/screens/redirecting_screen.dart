import 'package:chatting_app/screens/dummy.dart';
import 'package:chatting_app/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedirectingScreen extends StatelessWidget {
  const RedirectingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data != null) {
          return Dummy();
        }
        return RegistrationScreen();
      },
    );
  }
}
