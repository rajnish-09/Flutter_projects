import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/signup_screen.dart';
import 'package:task_management/utils/input_text_form_field.dart';
import 'package:task_management/utils/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late TapGestureRecognizer signupRecognizer;

  @override
  void initState() {
    super.initState();
    signupRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SignupScreen()),
        );
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Text(
              "Sign In",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Please sign in to continue", style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            InputTextFormFIeld(
              emailController: emailController,
              icon: Icons.email,
              hintText: "Enter Email",
            ),
            SizedBox(height: 20),
            InputTextFormFIeld(
              emailController: passwordController,
              icon: Icons.key,
              hintText: "Enter password",
            ),
            SizedBox(height: 20),
            SubmitButton(buttonText: 'Login', onPressed: () {}),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget password?",
                    style: TextStyle(color: Color(0xff0060F1)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Doesn't have an account? "),
                  TextSpan(
                    text: 'Signup',
                    style: TextStyle(color: Color(0xff0060F1)),
                    recognizer: signupRecognizer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
