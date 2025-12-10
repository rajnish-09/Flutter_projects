import 'package:flutter/material.dart';

class BmiDisplay extends StatefulWidget {
  final double bmiValue;
  final String gender;
  final double height, weight, age;
  const BmiDisplay({
    super.key,
    required this.bmiValue,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
  });

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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Your BMI is : ${widget.bmiValue.toStringAsFixed(2)}",
              //   style: TextStyle(fontSize: 25, color: Colors.white),
              // ),
              Text(
                "Your details",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Gender: ${widget.gender}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),

              Text(
                "Height: ${widget.height.toStringAsFixed(0)} cm",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),

              Text(
                "Weight: ${widget.weight.toStringAsFixed(0)} kg",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),

              Text(
                "Age: ${widget.age.toStringAsFixed(0)} years",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),

              Text(
                "BMI: ${widget.bmiValue.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
