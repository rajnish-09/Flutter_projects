import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './gender_card.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  double weight = 50;
  double age = 18;

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
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "180",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "cm",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    buildProgressBar(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  WeightAgeCard(
                    title: 'Weight',
                    value: '${weight.round()}',
                    onIncrement: () {
                      setState(() {
                        weight++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        weight--;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  WeightAgeCard(
                    title: 'Age',
                    value: '${age.round()}',
                    onIncrement: () {
                      setState(() {
                        age++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        age--;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgressBar() {
    return SizedBox(
      height: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: LinearProgressIndicator(
          value: 0.5,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }
}

class WeightAgeCard extends StatelessWidget {
  final String title, value;
  final VoidCallback onIncrement, onDecrement;
  const WeightAgeCard({
    super.key,
    required this.title,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
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
          children: [
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.grey)),
            Text(value, style: TextStyle(fontSize: 50, color: Colors.white)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(65, 158, 158, 158),
                    ),
                    child: Icon(Icons.remove, size: 20),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: onIncrement,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(65, 158, 158, 158),
                    ),
                    child: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
