import 'package:chatting_app/widgets.dart/custom_app_bar.dart';
import 'package:chatting_app/widgets.dart/input_field.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), 
    body: Column(
      children: [
        SizedBox(height: 30,),
        Text("Get Started", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),), 
        SizedBox(height: 20,),
        Text("Start with signing in or sign up"), 
        SizedBox(height: 10,),
      ],
    ),
    );
  }
}
