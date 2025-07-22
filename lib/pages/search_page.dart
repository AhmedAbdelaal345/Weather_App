import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  SearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Search a City",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Color(0xffFFAD3B),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                enableSuggestions: true,
                onChanged: (value) {
                  cityName = value;
                },
                onSubmitted: (String data) async {
                  if (data.isNotEmpty) {
                    cityName = data;
                    await _searchWeather(context, cityName!);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 35,
                    horizontal: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFFAD3B)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffFFAD3B)),
                  ),
                  labelText: "Search",
                  labelStyle: TextStyle(color: Color(0xffFFAD3B)),
                  hintText: "Enter City Name",
                  focusColor: Color(0xffFFAD3B),

                  suffixIcon: InkWell(
                    onTap: () async {
                      WeatherService service = WeatherService();
                      if (cityName != null && cityName!.isNotEmpty) {
                        await _searchWeather(context, cityName!);
                      }
                    },
                    child: Icon(Icons.search),
                  ),
                ),
                autocorrect: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _searchWeather(BuildContext context, String city) async {
    try {
      WeatherService service = WeatherService();
      WeatherModel? weather = await service.getWeather(cityName: city);

      if (weather != null) {
        BlocProvider.of<WeatherCubit>(context).getWeather(cityName: city);
        Navigator.pop(context);
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not find weather data for $city')),
        );
      }
    } catch (e) {
      print('Error searching weather: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error occurred while searching')));
    }
  }
}
