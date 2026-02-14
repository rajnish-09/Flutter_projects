import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/images/login_background_blob2.png'),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/images/login_background_blob1.png'),
        ),

        Positioned(
          top: 200,
          right: 0,
          child: Image.asset('assets/images/login_background_blob3.png'),
        ),
      ],
    );
  }
}
