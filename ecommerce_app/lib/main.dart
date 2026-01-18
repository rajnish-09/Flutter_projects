import 'package:ecommerce_app/ui/get_started_screen.dart';
import 'package:ecommerce_app/ui/login_screen.dart';
import 'package:ecommerce_app/ui/shop_screen.dart';
import 'package:ecommerce_app/ui/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ShopScreen());
  }
}
