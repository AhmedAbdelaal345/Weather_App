import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return WeatherProvider();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch:
            Provider.of<WeatherProvider>(context).weatherData == null
                ? Colors.blue
                : Provider.of<WeatherProvider>(
                  context,
                ).weatherData!.getThemeData(),
      ),

      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
