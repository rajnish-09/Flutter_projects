import 'package:ecommerce_app/widgets/auth/login_password_background.dart';
import 'package:ecommerce_app/widgets/auth/login_password_form.dart';
import 'package:flutter/material.dart';

class LoginPasswordScreen extends StatefulWidget {
  final String email;
  const LoginPasswordScreen({super.key, required this.email});

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [LoginPasswordBackground(), LoginPasswordForm(email: widget.email,)]),
    );
  }
}
