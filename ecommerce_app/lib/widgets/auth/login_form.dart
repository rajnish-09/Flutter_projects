import 'package:ecommerce_app/ui/login_password_screen.dart';
import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
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
          ),
          SizedBox(height: 20),
          SubmitButton(
            buttonText: 'Next',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPasswordScreen()),
              );
            },
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
