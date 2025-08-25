import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';

String baseUrl = "http://api.weatherapi.com/v1";
String apiKey = "952b5d680f7140a0bf6151650250705";

class WeatherService {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {


        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }

Future<WeatherModel?> getWeatherByLocation() async {
    WeatherModel? weather;
    try {
      Position position = await _determinePosition();
      Uri url = Uri.parse(
        "$baseUrl/forecast.json?key=$apiKey &q=${position.latitude},${position.longitude}&days=7&aqi=no&alerts=no",
      );
      http.Response response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
       weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      Uri url = Uri.parse(
        "$baseUrl/forecast.json?key=$apiKey &q=$cityName&days=7&aqi=no&alerts=no",
      );
      http.Response response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
       weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
