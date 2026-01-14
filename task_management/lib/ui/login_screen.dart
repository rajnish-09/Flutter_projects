import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/auth/bloc/auth_bloc.dart';
import 'package:task_management/auth/bloc/auth_event.dart';
import 'package:task_management/auth/bloc/auth_state.dart';
import 'package:task_management/ui/signup_screen.dart';
import 'package:task_management/widgets/input_text_form_field.dart';
import 'package:task_management/utils/show_sackbar.dart';
import 'package:task_management/widgets/input_text_form_field.dart';
import 'package:task_management/widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late TapGestureRecognizer signupRecognizer;
  AuthService authService = AuthService();

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

  // void loginUserWithEmail(String email, String password) async {
  //   try {
  //     await authService.loginUserWithEmail(email, password);
  //     if (!mounted) return;

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Successfully logged in')));
  //   } catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Please sign in to continue",
                  style: TextStyle(fontSize: 15),
                ),
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
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      showSnackbar(context, state.errorMessage);
                    }
                    if (state is AuthLoginSuccess) {
                      showSnackbar(context, 'Successfully loggeed in');
                    }
                  },
                  child: SubmitButton(
                    buttonText: 'Login',
                    onPressed: () {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      context.read<AuthBloc>().add(
                        LoginUserWithEmail(email: email, password: password),
                      );
                    },
                  ),
                ),
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is AuthLoginSuccess) {
                      return Center(
                        child: Text(
                          'Successfully logged in. UID: ${state.uid}',
                        ),
                      );
                    }
                    return Center(child: Text(''));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
