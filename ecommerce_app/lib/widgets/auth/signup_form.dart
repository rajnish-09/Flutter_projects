import 'package:ecommerce_app/bloc/auth/auth_bloc.dart';
import 'package:ecommerce_app/bloc/auth/auth_event.dart';
import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/show_snackbar.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignupFailed) {
              showSnackBar(
                context: context,
                msg: state.msg,
                backgroundColor: Colors.red,
              );
            }
          },
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                showSnackBar(
                  context: context,
                  msg: state.msg,
                  backgroundColor: Colors.green,
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create \nAccount",
                  style: GoogleFonts.raleway(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                InputTextFormFIeld(
                  controller: nameController,
                  icon: Icons.person,
                  hintText: 'Enter your name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                InputTextFormFIeld(
                  controller: emailController,
                  icon: Icons.email,
                  hintText: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                InputTextFormFIeld(
                  controller: phoneController,
                  icon: Icons.call,
                  hintText: 'Enter your phone number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                InputTextFormFIeld(
                  controller: passwordController,
                  icon: Icons.key,
                  hintText: 'Enter password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                InputTextFormFIeld(
                  controller: confirmPasswordController,
                  icon: Icons.key,
                  hintText: 'Re-type password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    }
                    if (value != passwordController.text.trim()) {
                      return "Passwords doesn't match";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                SubmitButton(
                  buttonText: 'Signup',
                  onPressed: () {
                    final user = UserModel(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    context.read<AuthBloc>().add(SignupEvent(user: user));
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
