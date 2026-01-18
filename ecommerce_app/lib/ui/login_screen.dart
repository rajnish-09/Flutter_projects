import 'package:ecommerce_app/ui/widgets/auth/login_background.dart';
import 'package:ecommerce_app/ui/widgets/auth/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [LoginBackground(), LoginForm()]));
  }
}
