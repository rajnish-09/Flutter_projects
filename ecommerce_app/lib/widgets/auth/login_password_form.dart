import 'package:ecommerce_app/ui/login_screen.dart';
import 'package:ecommerce_app/ui/main_navigation_screen.dart';
import 'package:ecommerce_app/ui/shop_screen.dart';
import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPasswordForm extends StatefulWidget {
  const LoginPasswordForm({super.key});

  @override
  State<LoginPasswordForm> createState() => _LoginPasswordFormState();
}

class _LoginPasswordFormState extends State<LoginPasswordForm> {
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Hello, Name",
            style: GoogleFonts.raleway(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Type your password",
            style: GoogleFonts.nunitoSans(fontSize: 19),
          ),
          SizedBox(height: 20),
          InputTextFormFIeld(
            controller: passwordController,
            icon: Icons.key,
            hintText: 'Enter password',
            obscureText: true,
          ),
          SizedBox(height: 20),
          SubmitButton(
            buttonText: 'Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopScreen()),
              );
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not you?", style: GoogleFonts.nunitoSans(fontSize: 15)),
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
                      builder: (context) => MainNavigationScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_right_alt, color: Colors.white),
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
