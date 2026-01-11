import 'package:chatting_app/screens/login_screen.dart';
import 'package:chatting_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices firebaseServices = FirebaseServices();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await firebaseServices.logoutUser();
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
