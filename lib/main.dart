import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/weather_cubit.dart';
import 'package:flutter_application_1/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocProvider(
      create: (context) => WeatherCubit(weatherRepository: WeatherRepository())
        ..getWeatherData(),
      child: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return loading();
        } else if (state is WeatherLoaded) {
          return details(state,height);
        } else if (state is WeatherError) {
          return error(state);
        }
        return Container();
      }),
    ));
  }

  error(WeatherError state) => Center(
        child: Text(state.error),
      );

  loading() => Center(
        child: CircularProgressIndicator(),
      );

  details(WeatherLoaded state, height) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.weather.cityName,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.blue,
                fontSize: 40
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(state.weather.tempInfo.temperature.toString() + ' °F' ,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
            )
          ),
          SizedBox(
            height: 20,
          ),
          Image.network(state.weather.iconUrl, height: height * .30),
          SizedBox(
            height: 20,
          ),
          Text(state.weather.weatherInfo.description,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
            )
          ),
        ],
      ));
}
