import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderCardBox extends StatelessWidget {
  final String genderLabel;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCardBox({
    super.key,
    required this.icon,
    required this.genderLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isSelected
                ? const Color.fromARGB(183, 228, 45, 45)
                : const Color.fromARGB(65, 158, 158, 158),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                genderLabel,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
