import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servup/views/auth/login_view.dart';
import 'package:servup/views/auth/signup_view.dart';
import 'package:servup/views/user/book_now_view.dart';
import 'package:servup/views/user/home_view.dart';
import 'package:servup/views/user/provider_profile_view.dart';
import 'package:servup/views/user/service_listing_view.dart';
import 'package:servup/views/user/user_profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
      ),
      home: UserProfileView(),
    );
  }
}
