import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';

class ApiService {
  final String apiKey = 'c39503790fbe755bf7fb32c6a57e4f68';

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=c39503790fbe755bf7fb32c6a57e4f68',
      ),
    );
    final jsonData = jsonDecode(response.body);
    WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
    return weatherModel;
  }
}
