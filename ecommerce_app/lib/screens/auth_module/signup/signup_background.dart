import 'package:flutter/material.dart';

class SignupBackground extends StatelessWidget {
  const SignupBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/images/signup_page_blob1.png'),
        ),
        Positioned(
          top: 50,
          right: 0,
          child: Image.asset('assets/images/signup_page_blob2.png'),
        ),
      ],
    );
  }
}
