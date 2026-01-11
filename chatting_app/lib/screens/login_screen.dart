import 'package:chatting_app/screens/dummy.dart';
import 'package:chatting_app/services/firebase_services.dart';
import 'package:chatting_app/widgets.dart/custom_app_bar.dart';
import 'package:chatting_app/widgets.dart/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseServices firebaseServices = FirebaseServices();
  String? errorMessage;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Remember to get up and stretch once a while.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              InputField(
                controller: emailController,
                prefixIcon: Icons.person,
                hintText: 'Email',
              ),
              SizedBox(height: 30),
              InputField(
                controller: passwordController,
                prefixIcon: Icons.password,
                hintText: 'Password',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  if (email.isEmpty && password.isEmpty) {
                    setState(() {
                      errorMessage = 'All fields are required';
                    });
                  } else {
                    try {
                      final userId = await firebaseServices.loginUser(
                        email,
                        password,
                      );

                      if (userId.isNotEmpty) {
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Dummy()),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        errorMessage = e.message.toString();
                      });
                    }
                  }
                },
                child: Text("Login"),
              ),
              Text(errorMessage ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
