import 'package:ecommerce_app/bloc/auth/auth_bloc.dart';
import 'package:ecommerce_app/bloc/auth/auth_event.dart';
import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/screens/admin_module/admin_dashboard.dart';
import 'package:ecommerce_app/screens/login_password_screen.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/show_snackbar.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseService firebaseService = FirebaseService();

  void checkUserRole() async {
    final user = await firebaseService.getUser();

    if (user.role == 'user') {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      );
    } else if (user.role == 'admin') {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => MainNavigationScreen()),
            // );
            checkUserRole();
          }
        },
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginFailed) {
                showSnackBar(
                  context: context,
                  msg: state.msg,
                  backgroundColor: Colors.red,
                );
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         LoginPasswordScreen(email: emailController.text.trim()),
                        //   ),
                        // );
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
                          icon: Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                          ),
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
      ),
    );
  }
}
