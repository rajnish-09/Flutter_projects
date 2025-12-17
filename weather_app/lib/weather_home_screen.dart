import 'package:flutter/material.dart';
import 'package:weather_app/api_service.dart';
import 'package:weather_app/weather_report.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  ApiService apiService = ApiService();
  TextEditingController nameController = TextEditingController();
  String? nameError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0C1E),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset(
                    'assets/images/weather.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Discover the weather\nin your city",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Get to know your weather maps and\nradar precepition forecast.',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {
                        nameError = null;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      errorText: nameError,
                      border: cityInputBorder(),
                      enabledBorder: cityInputBorder(),
                      focusedBorder: cityInputBorder(),
                      hintText: 'Enter city name',
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(117, 255, 255, 255),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String cityName = nameController.text;
                        if (cityName.isEmpty) {
                          setState(() {
                            nameError = 'Please enter city name';
                          });
                          return;
                        } else {
                          final data = await apiService.getWeather(cityName);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherReport(
                                weatherData: data,
                                cityName: cityName,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0195FF),
                        foregroundColor: const Color.fromARGB(
                          255,
                          232,
                          232,
                          232,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Get weather'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder cityInputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: const Color.fromARGB(180, 255, 255, 255)),
  );
}
