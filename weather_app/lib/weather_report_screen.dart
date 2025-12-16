// import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api_service.dart';
import 'package:weather_app/weather_model.dart';
// import 'package:weather_app/api_service.dart';

class WeatherReportScreen extends StatefulWidget {
  final WeatherModel weatherData;
  final String cityName;
  final ApiService apiService;
  const WeatherReportScreen({
    super.key,
    required this.weatherData,
    required this.cityName,
    required this.apiService,
  });

  @override
  State<WeatherReportScreen> createState() => _WeatherReportScreenState();
}

class _WeatherReportScreenState extends State<WeatherReportScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String dateStr = DateFormat('dd, MMMM yyyy').format(today);
    String month = DateFormat('MMMM').format(today);
    String time = DateFormat('hh:mm a').format(today);

    double kelvin = widget.weatherData.main.temp;
    double celsius = kelvin - 273.15;
    double minTempCelsius = widget.weatherData.main.tempMin - 273.15;
    double windSpeed = widget.weatherData.wind.speed * 3.6;

    Future<Position> determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();

      if (!serviceEnabled) {
        return Future.error("Location is not enabled.");
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied.');
        }
      }

      return await Geolocator.getCurrentPosition();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Position position = await determinePosition();
          double lat = position.latitude;
          double lon = position.longitude;
          widget.apiService.getCurrentLocation(lat, lon);
        },
        child: Icon(Icons.my_location),
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 10),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_sharp, size: 20),
                  ),
                ),
                title: Center(
                  child: Text(
                    widget.cityName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                subtitle: Center(child: Text(dateStr)),
                trailing: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.more_horiz),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                // height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            month,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            time,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${celsius.toStringAsFixed(0)}\u2103",
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://i.pinimg.com/1200x/06/c4/f7/06c4f70ec5931e2342e703e8a3f0a253.jpg',
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          WeatherInfoCard(
                            icon: Icons.wind_power,
                            label: "Wind",
                            value: "${windSpeed.toStringAsFixed(2)} km/hr",
                          ),
                          SizedBox(width: 10),
                          WeatherInfoCard(
                            icon: Icons.wind_power,
                            label: "Min Temp",
                            value: '${minTempCelsius.toStringAsFixed(0)}\u2103',
                          ),
                          SizedBox(width: 10),

                          WeatherInfoCard(
                            icon: Icons.wind_power,
                            label: "Humidity",
                            value: '${widget.weatherData.main.humidity}%',
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(widget.weatherData.weather[0].main),
                    ],
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

class WeatherInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const WeatherInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(88, 182, 227, 248),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(height: 10),
                Text(label, style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text(value, style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
