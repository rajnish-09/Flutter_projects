import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/display_card_widget.dart';
import 'package:weather_app/weather_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.weatherIcons,
    required this.weatherMain,
    required this.weatherDescription,
    required this.tempInCelsius,
    required this.speedInKmPerHr,
    required this.humidity,
    required this.pressure,
  });

  final WeatherIcons weatherIcons;
  final String weatherMain;
  final String weatherDescription;
  final double tempInCelsius;
  final double speedInKmPerHr;
  final int humidity;
  final int pressure;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
