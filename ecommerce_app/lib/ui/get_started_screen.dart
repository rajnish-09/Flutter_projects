import 'package:ecommerce_app/ui/signup_screen.dart';
import 'package:ecommerce_app/ui/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                // width: 100,
                // height: 100,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/get_started_background_image.png',
                ),
              ),
              Spacer(),
              Text(
                "ShopEase",
                style: GoogleFonts.raleway(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Beautiful eCommerce UI Kit \nfor your online store",
                style: GoogleFonts.nunitoSans(fontSize: 19),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SubmitButton(buttonText: "Let's get started", onPressed: () {}),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I already have an account",
                    style: GoogleFonts.nunitoSans(fontSize: 15),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xff004CFF),
                      padding: EdgeInsets.all(5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    icon: Icon(Icons.arrow_right_alt, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
