import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/api_service.dart';
import 'package:weather_app/weather_model.dart';

class WeatherReport extends StatefulWidget {
  final WeatherModel weatherData;
  final String cityName;
  const WeatherReport({
    super.key,
    required this.weatherData,
    required this.cityName,
  });

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  ApiService apiService = ApiService();
  WeatherModel? weatherModel;
  String currentCityName = '';

  @override
  void initState() {
    super.initState();
    weatherModel = widget.weatherData;
    currentCityName = widget.cityName;
  }

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    } else {
      return s[0].toUpperCase() + s.substring(1);
    }
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    String weatherDescription = capitalize(
      weatherModel!.weather[0].description,
    );
    double tempInKelvin = weatherModel!.main.temp;
    double tempInCelsius = tempInKelvin - 273.15;
    double speedInMPerS = weatherModel!.wind.speed;
    double speedInKmPerHr = speedInMPerS * 3.6;
    int humidity = weatherModel!.main.humidity;
    int pressure = weatherModel!.main.pressure;
    String weatherIcon = weatherModel!.weather[0].icon;
    return Scaffold(
      backgroundColor: Color(0xFF0B0C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0C1E),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(
        //       Icons.location_on,
        //       color: const Color.fromARGB(255, 255, 255, 255),
        //     ),
        //     SizedBox(width: 5),
        //     Text(widget.cityName, style: TextStyle(color: Colors.white)),
        //   ],
        // ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectedValue,
              dropdownColor: Color.fromARGB(255, 19, 20, 48),
              style: TextStyle(color: Colors.white),
              hint: Text("Select a city", style: TextStyle(color: Colors.grey)),
              items: [
                DropdownMenuItem(value: 'Kathmandu', child: Text("Kathmandu")),
                DropdownMenuItem(value: 'New delhi', child: Text("New delhi")),
                DropdownMenuItem(value: 'Beijing', child: Text("Beijing")),
                DropdownMenuItem(value: 'London', child: Text("London")),
                DropdownMenuItem(
                  value: 'Washington dc',
                  child: Text("Washington dc"),
                ),
              ],
              onChanged: (value) async {
                setState(() {
                  selectedValue = value;
                });
                if (value != null) {
                  final data = await apiService.getWeather(value);
                  setState(() {
                    weatherModel = data;
                    currentCityName = value;
                  });
                }
              },
            ),
          ),
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
                Image.network(
                  'https://openweathermap.org/img/wn/$weatherIcon.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                SizedBox(height: 10),
                Text(
                  weatherDescription,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: tempInCelsius.toStringAsFixed(0),
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
                      icon: FontAwesomeIcons.wind,
                      value: '${speedInKmPerHr.toStringAsFixed(2)} km/Hr',
                      label: 'Wind',
                    ),
                    DataDisplayCard(
                      icon: FontAwesomeIcons.cloudRain,
                      value: '$humidity%',
                      label: 'Humidity',
                    ),
                    DataDisplayCard(
                      icon: FontAwesomeIcons.gauge,
                      value: '$pressure hPa',
                      label: 'Pressure',
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
            Text(value, style: TextStyle(fontSize: 15, color: Colors.white)),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
