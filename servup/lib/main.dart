import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servup/screens/auth/login_view.dart';
import 'package:servup/screens/auth/signup_view.dart';
import 'package:servup/screens/user/book_now_screen.dart';
import 'package:servup/screens/user/booking_confirmation_screen.dart';
import 'package:servup/screens/user/favorites_screen.dart';
import 'package:servup/screens/user/home_screen.dart';
import 'package:servup/screens/user/provider_profile_screen.dart';
import 'package:servup/screens/user/reviews_ratings_screen.dart';
import 'package:servup/screens/user/service_listing_screen.dart';
import 'package:servup/screens/user/user_profile_screen.dart';

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
      home: ReviewsRatingsScreen(),
    );
  }
}
