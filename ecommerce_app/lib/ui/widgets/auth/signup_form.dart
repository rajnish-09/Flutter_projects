import 'package:ecommerce_app/ui/widgets/input_textformfield.dart';
import 'package:ecommerce_app/ui/widgets/submit_button.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Text(
            "Create \nAccount",
            style: GoogleFonts.raleway(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
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
          Spacer(),
          SubmitButton(buttonText: 'Signup', onPressed: () {}),
          Spacer(),
        ],
      ),
    );
  }
}
