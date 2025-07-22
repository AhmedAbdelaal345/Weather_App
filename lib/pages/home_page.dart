import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    WeatherModel? weatherData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            BlocProvider.of<WeatherCubit>(
              context,
            ).weatherModel!.getThemeData() ??
            Colors.blue, // Default color if null
        actions: [
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
        title: Text(
          "Weather App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SucessState) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return SuccessBody(weatherData: weatherData);
          } else if (state is FailureState) {
            return FailureBody();
          } else {
            return DefaultBody();
          }
        },
      ),
    );
    // body:
    //       );
  }
}

class DefaultBody extends StatelessWidget {
  const DefaultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "There is no weather 😔. Start searching.",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Text(
            "Searching now 🔍",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class FailureBody extends StatelessWidget {
  const FailureBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "There is Problem 😔. please searching agian.",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Text(
            "Searching again , now 🔍",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({super.key, required this.weatherData});

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherData!.getThemeData(),
            weatherData!.getThemeData()[200]!,
            weatherData!.getThemeData()[100]!,
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
            "${weatherData!.country}",
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          ),
          Text(
            "Updated at: ${weatherData!.date.hour}:${weatherData!.date.minute}:${weatherData!.date.second}",
            style: TextStyle(fontSize: 24),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage(), fit: BoxFit.scaleDown),
              Text(
                "${weatherData!.temp.toInt()}", // Use actual temperature
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    "MaxTemp: ${weatherData!.maxTemp.toInt()}",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    "MinTemp: ${weatherData!.minTemp.toInt()}",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            "${weatherData!.weatherState}",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
