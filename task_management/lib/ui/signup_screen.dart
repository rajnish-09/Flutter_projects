import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/ui/login_screen.dart';
import 'package:task_management/utils/input_text_form_field.dart';
import 'package:task_management/utils/submit_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late TapGestureRecognizer loginRecognizer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      };
  }

  void signupUser() async {
    if (_formKey.currentState!.validate()) {
      // All fields are valid
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Call your Firebase signup logic here
      // print("Signup successful for $name, $email");
      try {
        AuthService authService = AuthService();
        final uid = await authService.signUpWithEmail(
          name: name,
          email: email,
          password: password,
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered successfully. UID: $uid')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed ${e.toString()}')),
        );
      }
      // Navigator.pop(context);
    }
  }

  // void signupUser(
  //   String name,
  //   String email,
  //   String password,
  //   String confirmPassword,
  // ) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Please sign in to continue",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputTextFormFIeld(
                        emailController: nameController,
                        icon: Icons.person,
                        hintText: 'Enter full name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      InputTextFormFIeld(
                        emailController: emailController,
                        icon: Icons.email,
                        hintText: "Enter email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      InputTextFormFIeld(
                        emailController: passwordController,
                        icon: Icons.key,
                        hintText: 'Enter password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      InputTextFormFIeld(
                        emailController: confirmPasswordController,
                        icon: Icons.key,
                        hintText: 'Re-type password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password is required";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SubmitButton(
                        buttonText: 'Signup',
                        onPressed: () {
                          signupUser();
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Color(0xff0060F1)),
                        recognizer: loginRecognizer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    loginRecognizer.dispose();
    super.dispose();
  }
}
