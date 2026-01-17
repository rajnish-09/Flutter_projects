import 'package:chat_app/ui/login_screen.dart';
import 'package:chat_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // SizedBox(height: 20),
              Spacer(),
              Image.asset('assets/icons/get_started_logo.png'),
              SizedBox(height: 40),
              Text(
                "Connect easily with\nyour family and friends \nover countries",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text("Terms and conditions", style: TextStyle(fontSize: 13)),
              SizedBox(height: 15),
              SubmitButton(
                buttonText: 'Get Started',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
