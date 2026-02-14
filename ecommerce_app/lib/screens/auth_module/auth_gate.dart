import 'package:ecommerce_app/screens/auth_module/login/login_screen.dart';
import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin_module/admin_dashboard.dart' show AdminDashboard;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoginScreen();
        }
        return FutureBuilder(
          future: firebaseService.getUser(),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if (roleSnapshot.hasData) {
              final userRole = roleSnapshot.data!.role;
              if (userRole == 'user') {
                return MainNavigationScreen();
              } else if (userRole == 'admin') {
                return AdminDashboard();
              }
            }
            return LoginScreen();
          },
        );
      },
    );
  }
}
