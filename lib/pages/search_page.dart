import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  SearchPage({super.key});
  VoidCallback? updateUi;
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
                  cityName = data;
                  WeatherService service = WeatherService();

                  WeatherModel? weather = await service.getWeather(
                    cityName: cityName!,
                  );
                  Provider.of<WeatherProvider>(context, listen: false)
                      .weatherData = weather;
                  // updateUi!();
                  Navigator.pop(context);
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

                  suffixIcon: GestureDetector(
                    onTap: () async {
                      WeatherService service = WeatherService();

                      WeatherModel? weather = await service.getWeather(
                        cityName: cityName!,
                      );
                      Provider.of<WeatherProvider>(context, listen: false)
                          .weatherData = weather;
                      // updateUi!();
                      Navigator.pop(context);
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
}
