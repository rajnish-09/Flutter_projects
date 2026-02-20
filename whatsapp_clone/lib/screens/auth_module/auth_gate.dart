import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/auth_module/login_screen.dart';
import 'package:whatsapp_clone/screens/user_module/profile_screen.dart';
import 'package:whatsapp_clone/screens/user_module/main_navigation_screen.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // if(snapshot.connectionState==ConnectionState.waiting){
        //   return
        // }

        if (snapshot.hasData) {
          return MainNavigationScreen();
        }
        return LoginScreen();
      },
    );
  }
}
