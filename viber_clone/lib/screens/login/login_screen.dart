import 'package:flutter/material.dart';
import 'package:viber_clone/screens/login/login_background.dart';
import 'package:viber_clone/screens/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [LoginBackground(), LoginForm()]),
    );
  }
}
