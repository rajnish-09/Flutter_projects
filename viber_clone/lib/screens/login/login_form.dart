import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viber_clone/submit_button.dart';
import 'package:viber_clone/widgets/input_textformfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SignupScreen(),
                            //   ),
                            // );
                          },
                          icon: Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.))
                    // SizedBox(height: 70),
                  ],
                ),
              ),
            ),
        ),
    );
  }
}