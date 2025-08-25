// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherCubit(WeatherService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
             MaterialColor themeColor = Colors.blue;

    
        if (state is SucessState) {
          themeColor = BlocProvider.of<WeatherCubit>(context).weatherModel?.getThemeData()?? Colors.blue;
        }

        return MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            primarySwatch: themeColor,
            appBarTheme: AppBarTheme(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
            ),
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}