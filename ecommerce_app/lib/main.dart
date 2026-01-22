import 'package:ecommerce_app/ui/get_started_screen.dart';
import 'package:ecommerce_app/ui/login_screen.dart';
import 'package:ecommerce_app/ui/main_navigation_screen.dart';
import 'package:ecommerce_app/ui/product_display_screen.dart';
import 'package:ecommerce_app/ui/shop_screen.dart';
import 'package:ecommerce_app/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.nunitoSansTextTheme()),
      home: GetStartedScreen(),
    );
  }
}
