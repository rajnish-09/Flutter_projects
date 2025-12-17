class WeatherIcons {
  String getWeatherSymbol(String weatherMain) {
    switch (weatherMain) {
      case 'Thunderstorm':
        return "⛈️";
      case 'Drizzle':
        return "🌦️";
      case 'Rain':
        return "🌧️";
      case 'Snow':
        return "❄️";
      case 'Clear':
        return "☀️";
      case 'Clouds':
        return "☁️";
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        return "🌫️";
      default:
        return "❓";
    }
  }
}
