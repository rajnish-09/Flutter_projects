import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderCardBox extends StatelessWidget {
  final String genderLabel;
  final IconData icon;
  const GenderCardBox({
    super.key,
    required this.icon,
    required this.genderLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(65, 158, 158, 158),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 50, color: Colors.white),
            Text(
              genderLabel,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
