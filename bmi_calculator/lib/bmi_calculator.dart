import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BmiCalculator extends StatelessWidget {
  const BmiCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 22, 39),
      appBar: AppBar(
        leading: Icon(Icons.calculate, color: Colors.white),
        title: Text(
          "BMI calculator",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 5, 22, 39),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GenderCardBox(
                    icon: FontAwesomeIcons.mars,
                    genderLabel: 'MALE',
                  ),
                  SizedBox(width: 10),
                  GenderCardBox(
                    icon: FontAwesomeIcons.venus,
                    genderLabel: 'FEMALE',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(94, 158, 158, 158),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "HEIGHT",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          color: const Color.fromARGB(94, 158, 158, 158),
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
