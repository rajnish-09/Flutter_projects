import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servup/bloc/auth/auth_bloc.dart';
import 'package:servup/bloc/auth/auth_event.dart';
import 'package:servup/bloc/auth/auth_state.dart';
import 'package:servup/show_snackbar.dart';
import 'package:servup/utils/app_colors.dart';
import 'package:servup/utils/app_router.dart';
import 'package:servup/widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9EDF6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    context.go(AppRouter.home);
                  }
                  if (state is LoginFailed) {
                    showSnackBar(
                      context: context,
                      msg: state.msg,
                      backgroundColor: AppColors.failedBackground,
                    );
                  }
                },
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "Login to manage local services",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 129, 129, 129),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 124, 124, 124),
                            ),
                          ),
                          SizedBox(height: 5),

                          CustomInputField(
                            controller: emailController,
                            hintText: 'Enter email address',
                            validate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Enter valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    124,
                                    124,
                                    124,
                                  ),
                                ),
                              ),
                              Text(
                                "Forget password?",
                                style: TextStyle(color: Color(0xff005CAB)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          CustomInputField(
                            controller: passwordController,
                            hintText: 'Enter password',
                            validate: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                                emailController.clear();
                                passwordController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff005CAB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  }
                                  return Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(child: Text("OR")),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              label: Text(
                                "Google",
                                style: TextStyle(color: Colors.black),
                              ),
                              icon: Icon(Icons.g_mobiledata),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            context.push(AppRouter.signup);
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Color(0xff005CAB)),
                          ),
                        ),
                      ],
                    ),
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
