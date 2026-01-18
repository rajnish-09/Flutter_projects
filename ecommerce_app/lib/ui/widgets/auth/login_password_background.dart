import 'package:flutter/material.dart';

class LoginPasswordBackground extends StatelessWidget {
  const LoginPasswordBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/images/login_password_screen_blob2.png'),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/images/login_password_screen_blob1.png'),
        ),
      ],
    );
  }
}
