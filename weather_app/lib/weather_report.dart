import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/api_service.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_icons.dart';

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
  WeatherIcons weatherIcons = WeatherIcons();
  WeatherModel? weatherModel;
  String currentCityName = '';
  int currentIndex = 0;

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

  void _changeNavigationItem(int index) {
    setState(() {
      currentIndex = index;
    });
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
    String weatherMain = weatherModel!.weather[0].main;

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            SizedBox(width: 5),
            Text(currentCityName, style: TextStyle(color: Colors.white)),
          ],
        ),

        iconTheme: IconThemeData(color: Colors.white),
      ),

      endDrawer: Drawer(
        backgroundColor: Color(0xFF161729),
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Saved locations",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DrawerListItem(title: 'Kathmandu', changeWeather: updateWeather),
            DrawerListItem(title: 'New delhi', changeWeather: updateWeather),
            DrawerListItem(title: 'Beijing', changeWeather: updateWeather),
            DrawerListItem(title: 'London', changeWeather: updateWeather),
            DrawerListItem(title: 'Paris', changeWeather: updateWeather),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color(0xFF161729),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: _changeNavigationItem,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.blue,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Location',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Account',
                ),
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
                  weatherIcons.getWeatherSymbol(weatherMain),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.6,
                ),
                SizedBox(height: 10),
                Text(
                  weatherDescription,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 15),
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

                SizedBox(height: 20),
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

  void updateWeather(String cityName) async {
    final data = await apiService.getWeather(cityName);
    setState(() {
      weatherModel = data;
      currentCityName = cityName;
    });
  }
}

class DrawerListItem extends StatelessWidget {
  final String title;
  final Function(String) changeWeather;
  const DrawerListItem({
    super.key,
    required this.title,
    required this.changeWeather,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        changeWeather(title);
        Navigator.pop(context);
      },
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
