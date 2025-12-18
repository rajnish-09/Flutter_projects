class WeatherIcons {
  String getWeatherSymbol(String weatherMain) {
    switch (weatherMain) {
      case 'Thunderstorm':
        return "assets/icons/thunderstorms.png";
      case 'Drizzle':
        return "assets/icons/drizzle.png";
      case 'Rain':
        return "assets/icons/rain.png";
      case 'Snow':
        return "assets/icons/snow.png";
      case 'Clear':
        return "assets/icons/clear.png";
      case 'Clouds':
        return "assets/icons/clouds.png";
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        return "assets/icons/hazze.png";
      default:
        return "assets/icons/error.png";
    }
  }
}
