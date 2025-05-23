import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

String baseUrl = "http://api.weatherapi.com/v1";
String apiKey = "952b5d680f7140a0bf6151650250705";

class WeatherService {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      Uri url = Uri.parse("$baseUrl/forecast.json?key=$apiKey&q=$cityName");
      http.Response response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
