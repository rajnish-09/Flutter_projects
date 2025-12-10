import 'package:bmi_calculator/bmi_display.dart';
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
  double height = 150;
  bool isMaleSelected = false, isFemaleSelected = false;
  String? genderError;

  void selectedGender(String gender) {
    setState(() {
      if (gender == 'male') {
        isMaleSelected = true;
        isFemaleSelected = false;
      } else {
        isMaleSelected = false;
        isFemaleSelected = true;
      }
    });
  }

  void validateGender() {
    if (isMaleSelected && isFemaleSelected) {
      setState(() {
        genderError = 'Please select a gender';
      });
      return;
    } else {
      genderError = null;
    }
  }

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
                    isSelected: isMaleSelected,
                    onTap: () => selectedGender('male'),
                  ),
                  SizedBox(width: 10),
                  GenderCardBox(
                    icon: FontAwesomeIcons.venus,
                    genderLabel: 'FEMALE',
                    isSelected: isFemaleSelected,
                    onTap: () => selectedGender('female'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(65, 158, 158, 158),
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
                          height.toStringAsFixed(0),
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
                    SliderTheme(
                      data: SliderTheme.of(context),
                      child: Slider(
                        value: height,
                        min: 80,
                        max: 250,
                        onChanged: (value) {
                          setState(() {
                            height = value.toDouble();
                          });
                        },
                      ),
                    ),
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
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  String gender;
                  if (isFemaleSelected) {
                    gender = 'female';
                  } else {
                    gender = 'male';
                  }
                  double heightInM = height / 100;
                  double bmi = weight / (heightInM * heightInM);
                  validateGender();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BmiDisplay(
                        bmiValue: bmi,
                        gender: gender,
                        height: height,
                        weight: weight,
                        age: age,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(237, 228, 63, 51),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "CALCULATE",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          color: const Color.fromARGB(65, 158, 158, 158),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.grey)),
            Text(value, style: TextStyle(fontSize: 50, color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(24, 158, 158, 158),
                  child: IconButton(
                    onPressed: onDecrement,
                    icon: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(24, 158, 158, 158),
                  child: IconButton(
                    onPressed: onIncrement,
                    icon: Icon(Icons.add, color: Colors.white),
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
