import 'package:ecommerce_app/widgets/auth/signup_background.dart';
import 'package:ecommerce_app/widgets/auth/signup_form.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SignupBackground(),
            SignupForm(),
          ],
        ),
      ),
    );
  }
}
