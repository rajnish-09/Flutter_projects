import 'package:chatting_app/screens/onboarding_screen.dart';
import 'package:chatting_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegistrationScreen());
  }
}
