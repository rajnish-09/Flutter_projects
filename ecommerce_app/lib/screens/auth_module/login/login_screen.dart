import 'package:ecommerce_app/screens/admin_module/admin_dashboard.dart';
import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/screens/auth_module/login/login_background.dart';
import 'package:ecommerce_app/screens/auth_module/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseService firebaseService = FirebaseService();

 

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
