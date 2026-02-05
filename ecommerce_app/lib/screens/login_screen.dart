import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/widgets/auth/login_background.dart';
import 'package:ecommerce_app/widgets/auth/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseService firebaseService = FirebaseService();

  // void checkCurrentUser() async {
  //   final user = await firebaseService.currentUser();
  //   if (user != null) {
  //     if (!mounted) {
  //       return;
  //     }
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => MainNavigationScreen()),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [LoginBackground(), LoginForm()]),
    );
  }
}
