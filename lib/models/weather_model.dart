import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String country;
  String weatherState;

  WeatherModel({
    required this.country,
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherState,
  });

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData =
        data["forecast"]["forecastday"]?.first; // Use ?. to safely access
    if (jsonData == null) {
      throw Exception("Forecast data not available"); // Handle null case
    }
    return WeatherModel(
      country: data["location"]["name"] ?? "Unknown", // Provide default value
      date: DateTime.parse(data["current"]["last_updated"]),
      temp:
          jsonData["avgtemp_c"]?.toDouble() ?? 0.0, // Convert to double safely
      maxTemp:
          jsonData["day"]["maxtemp_c"]?.toDouble() ??
          0.0, // Convert to double safely
      minTemp:
          jsonData["day"]["mintemp_c"]?.toDouble() ??
          0.0, // Convert to double safely
      weatherState:
          jsonData["day"]["condition"]["text"] ??
          "Unknown", // Access condition description
    );
  }

  String getImage() {
    print("Weather State: $weatherState"); // Debugging line
    if (weatherState.trim().toLowerCase() == "cloudy" ||
        weatherState.trim().toLowerCase() == "overcast" ||
        weatherState.trim().toLowerCase() == "mist") {
      return "assets/images/cloudy.png";
    } else if (weatherState.trim().toLowerCase() ==
        "thundery outbreaks possible") {
      return "assets/images/thunderstorm.png";
    } else if (weatherState.trim().toLowerCase() == "sunny" ||
        weatherState.trim().toLowerCase() == "partly cloudy") {
      return "assets/images/clear.png";
    } else if (weatherState.trim().toLowerCase() == "light rain" ||
        weatherState.trim().toLowerCase() == "patchy rain nearby" ||
        weatherState.trim().toLowerCase() == "moderate rain at times" ||
        weatherState.trim().toLowerCase() == "moderate rain" ||
        weatherState.trim().toLowerCase() == "heavy rain at times" ||
        weatherState.trim().toLowerCase() == "heavy rain") {
      return "assets/images/rainy.png";
    } else {
      return "assets/images/snow.png";
    }
  }

  MaterialColor getThemeData() {
    print("Weather State: $weatherState"); // Debugging line
    if (weatherState.trim().toLowerCase() == "cloudy" ||
        weatherState.trim().toLowerCase() == "overcast" ||
        weatherState.trim().toLowerCase() == "mist") {
      return Colors.blueGrey;
    } else if (weatherState.trim().toLowerCase() ==
        "thundery outbreaks possible") {
      return Colors.yellow;
    } else if (weatherState.trim().toLowerCase() == "sunny" ||
        weatherState.trim().toLowerCase() == "partly cloudy") {
      return Colors.orange;
    } else if (weatherState.trim().toLowerCase() == "light rain" ||
        weatherState.trim().toLowerCase() == "patchy rain nearby" ||
        weatherState.trim().toLowerCase() == "moderate rain at times" ||
        weatherState.trim().toLowerCase() == "moderate rain" ||
        weatherState.trim().toLowerCase() == "heavy rain at times" ||
        weatherState.trim().toLowerCase() == "heavy rain") {
      return Colors.blue;
    } else {
      return Colors.blue;
    }
  }
}
