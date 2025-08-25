import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
        final appBarColor = weatherData?.getThemeData() ?? Colors.blue;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: appBarColor,
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<WeatherCubit>(context).getWeatherByLocation();
                },
                icon: Icon(Icons.location_on),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ],
            title: const Text(
              "Weather App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: () {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SucessState) {
              if (weatherData == null) {
                return const Center(
                  child: Text(
                    "No weather data available",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      weatherData.getThemeData(),
                      weatherData.getThemeData()[200]!,
                      weatherData.getThemeData()[100]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    Text(
                      weatherData.country,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Updated at: ${weatherData.date.hour}:${weatherData.date.minute}:${weatherData.date.second}",
                      style: const TextStyle(fontSize: 24),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          weatherData.getImage(),
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          "${weatherData.temp.toInt()}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "MaxTemp: ${weatherData.maxTemp.toInt()}",
                              style: const TextStyle(fontSize: 24),
                            ),
                            Text(
                              "MinTemp: ${weatherData.minTemp.toInt()}",
                              style: const TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      weatherData.weatherState,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 5),
                  ],
                ),
              );
            } else if (state is FailureState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "There is Problem 😔. please searching again.",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Searching again , now 🔍",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "There is no weather 😔. Start searching.",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Searching now 🔍",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }
          }(),
        );
      },
    );
  }
}
