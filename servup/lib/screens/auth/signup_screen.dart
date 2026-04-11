import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servup/bloc/auth/auth_bloc.dart';
import 'package:servup/bloc/auth/auth_event.dart';
import 'package:servup/bloc/auth/auth_state.dart';
import 'package:servup/models/user_model.dart';
import 'package:servup/services/firebase_service.dart';
import 'package:servup/show_snackbar.dart';
import 'package:servup/utils/app_colors.dart';
import 'package:servup/utils/app_router.dart';
import 'package:servup/widgets/custom_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SignupSuccess) {
                  context.push(AppRouter.login);
                }
                if (state is SignupSuccess) {
                  showSnackBar(
                    context: context,
                    msg: 'Signup Success. Please login',
                    backgroundColor: AppColors.successBackground,
                  );
                }
                if (state is SignupFailed) {
                  showSnackBar(
                    context: context,
                    msg: state.msg,
                    backgroundColor: AppColors.failedBackground,
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: const Text(
                          "Create Your Account",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: const Text(
                          "Welcome. Let's get you started",
                          style: TextStyle(
                            color: Color.fromARGB(255, 129, 129, 129),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Full Name"),
                      const SizedBox(height: 5),
                      CustomInputField(
                        controller: nameController,
                        hintText: 'Ram Shrestha',
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 10),
                      const Text("Email"),
                      const SizedBox(height: 5),
                      CustomInputField(
                        controller: emailController,
                        hintText: 'ram123@gmail.com',
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      const Text("Phone"),
                      const SizedBox(height: 5),
                      CustomInputField(
                        controller: phoneController,
                        hintText: '9800000000',
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          if (!RegExp(r'^(98|97)\d{8}$').hasMatch(value)) {
                            return 'Enter valid number';
                          }
                          return null;
                        },
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      const Text("Password"),
                      const SizedBox(height: 5),
                      CustomInputField(
                        controller: passwordController,
                        hintText: '**********',
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      const Text("Confirm Password"),
                      const SizedBox(height: 5),
                      CustomInputField(
                        controller: confirmPasswordController,
                        hintText: '**********',
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (value != passwordController.text.trim()) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        textInputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              UserModel user = UserModel(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              context.read<AuthBloc>().add(
                                SignupEvent(user: user),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff005CAB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 151, 151, 151),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              context.push(AppRouter.login);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Color(0xff005CAB)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
