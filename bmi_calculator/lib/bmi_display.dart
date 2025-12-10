import 'package:flutter/material.dart';

class BmiDisplay extends StatefulWidget {
  final double bmiValue;
  const BmiDisplay({super.key, required this.bmiValue});

  @override
  State<BmiDisplay> createState() => _BmiDisplayState();
}

class _BmiDisplayState extends State<BmiDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 22, 39),
      appBar: AppBar(
        title: Text(
          "Result",
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
        child: Center(
          child: Column(
            children: [
              Text(
                "Your BMI is : ${widget.bmiValue.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Text("Your details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              Text("Name: "),
              Text("Height: "),
              Text("Weight: "),
              Text("Age: "),
              Text("BMI: ")
            ],
          ),
        ),
      ),
    );
  }
}
