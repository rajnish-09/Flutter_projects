import 'package:chat_app/ui/login_screen.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  const SubmitButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff002DE3),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(buttonText, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
