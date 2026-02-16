import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/auth/auth_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_event.dart';
import 'package:whatsapp_clone/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/screens/home_screen.dart';
import 'package:whatsapp_clone/screens/signup_screen.dart';
import 'package:whatsapp_clone/widgets/input_textformfield.dart';
import 'package:whatsapp_clone/widgets/show_snackbar.dart';
import 'package:whatsapp_clone/widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoginFailed) {
                  showSnackBar(context, state.msg, Colors.red);
                }
                if (state is AuthLoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.28),
                  Text(
                    "Login",
                    style: GoogleFonts.raleway(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Good to see you back!',
                    style: GoogleFonts.nunitoSans(fontSize: 19),
                  ),
                  SizedBox(height: 30),
                  InputTextFormFIeld(
                    controller: emailController,
                    icon: Icons.email,
                    hintText: 'Enter email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  InputTextFormFIeld(
                    controller: passwordController,
                    icon: Icons.key,
                    hintText: 'Enter password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SubmitButton(
                    buttonText: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      context.read<AuthBloc>().add(
                        LoginEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.nunitoSans(fontSize: 15),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Color(0xff004CFF),
                          padding: EdgeInsets.all(5),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_right_alt, color: Colors.white),
                      ),
                    ],
                  ),
                  // SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
