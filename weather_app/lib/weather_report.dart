import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({super.key});

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0C1E),
        leading: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            SizedBox(width: 5),
            Text("Dhading", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          Icon(Icons.menu, color: const Color.fromARGB(255, 221, 221, 222)),
          SizedBox(width: 20),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF161729),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                BottomNavigationIcon(icon: Icons.home),
                BottomNavigationIcon(icon: Icons.search),
                BottomNavigationIcon(icon: FontAwesomeIcons.compass),
                BottomNavigationIcon(icon: Icons.person),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Today's Report",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/images/weather.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                SizedBox(height: 10),
                Text(
                  'It\'s cloudy',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '29',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "°",
                        style: TextStyle(color: Colors.blue, fontSize: 60),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Row(
                  children: [
                    DataDisplayCard(
                      icon: Icons.wind_power,
                      value: '22',
                      label: 'Wind',
                    ),
                    DataDisplayCard(
                      icon: Icons.wind_power,
                      value: '22',
                      label: 'Wind',
                    ),
                    DataDisplayCard(
                      icon: Icons.wind_power,
                      value: '22',
                      label: 'Wind',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  final IconData icon;
  const BottomNavigationIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 30,
            color: const Color.fromARGB(255, 103, 103, 103),
          ),
        ),
      ),
    );
  }
}

class DataDisplayCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const DataDisplayCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
