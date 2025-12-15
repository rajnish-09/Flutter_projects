import 'package:flutter/material.dart';

class WeatherReportScreen extends StatefulWidget {
  const WeatherReportScreen({super.key});

  @override
  State<WeatherReportScreen> createState() => _WeatherReportScreenState();
}

class _WeatherReportScreenState extends State<WeatherReportScreen> {
  DateTime today = DateTime.now();
  String dateTimeString = '${today.day} - ';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.arrow_back_ios_new_sharp, size: 20),
                ),
                title: Center(
                  child: Text(
                    "Dhading",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                subtitle: Center(child: Text("Date")),
                trailing: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.more_horiz),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
