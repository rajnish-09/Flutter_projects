import 'package:flutter/material.dart';
import 'package:weather_app/api_service.dart';
import 'package:weather_app/determine_location.dart';
import 'package:weather_app/dummy_page.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_icons.dart';
import 'package:weather_app/drawer_listItem_widget.dart';
import 'package:weather_app/report_home_page.dart';
import 'package:geolocator/geolocator.dart';

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
  DetermineLocation determineLocation = DetermineLocation();

  WeatherModel? weatherModel;
  String currentCityName = '';
  int currentIndex = 0;
  TextEditingController bottomSheetNameController = TextEditingController();
  String? bottomSheetNameError;
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

  void _changeNavigationItem(int index) async {
    if (index == 1) {
      _showModalBottomSheet();
    } else if (index == 2) {
      Position position = await determineLocation.getLocation();
      double lat = position.latitude;
      double lon = position.longitude;
      final data = await apiService.getCurrentLocation(lat, lon);
      currentCityName = data.name;
      setState(() {
        weatherModel = data;
      });
    }
    setState(() {
      currentIndex = index;
    });
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, bottomState) {
              return Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: Color.fromARGB(255, 20, 21, 52),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Enter city name",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: bottomSheetNameController,
                      onChanged: (_) {
                        bottomState(() {
                          bottomSheetNameError = null;
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter city name',
                        hintStyle: TextStyle(color: Colors.grey),
                        errorText: bottomSheetNameError,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    OutlinedButton(
                      onPressed: () async {
                        String cityName = capitalize(
                          bottomSheetNameController.text,
                        );

                        if (cityName.isEmpty) {
                          bottomState(() {
                            bottomSheetNameError = 'Please enter city name';
                          });
                          return;
                        } else {
                          final data = await apiService.getWeather(cityName);
                          setState(() {
                            weatherModel = data;
                            currentCityName = cityName;
                          });
                          bottomSheetNameController.text = '';
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Get weather",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
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

    List<Widget> _pages = [
      HomePage(
        weatherIcons: weatherIcons,
        weatherMain: weatherMain,
        weatherDescription: weatherDescription,
        tempInCelsius: tempInCelsius,
        speedInKmPerHr: speedInKmPerHr,
        humidity: humidity,
        pressure: pressure,
      ),
      HomePage(
        weatherIcons: weatherIcons,
        weatherMain: weatherMain,
        weatherDescription: weatherDescription,
        tempInCelsius: tempInCelsius,
        speedInKmPerHr: speedInKmPerHr,
        humidity: humidity,
        pressure: pressure,
      ),
      HomePage(
        weatherIcons: weatherIcons,
        weatherMain: weatherMain,
        weatherDescription: weatherDescription,
        tempInCelsius: tempInCelsius,
        speedInKmPerHr: speedInKmPerHr,
        humidity: humidity,
        pressure: pressure,
      ),

      // DummyPage(),
    ];

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
            Text(
              capitalize(currentCityName),
              style: TextStyle(color: Colors.white),
            ),
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
                  "Default locations",
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
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.person),
                //   label: 'Account',
                // ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: _pages[currentIndex],
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
