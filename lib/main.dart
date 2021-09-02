import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/weather_cubit.dart';
import 'package:flutter_application_1/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            WeatherCubit(weatherRepository: WeatherRepository())
              ..getWeatherData(),
        child:
            BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
              if (state is WeatherLoading) {
                return Center(child: Text('WeatherLoading'),);
              }
              if (state is WeatherLoaded) {
                return Center(child: Text(state.weather.cityName),);
              }
              if (state is WeatherError) {
                return Center(child: Text('WeatherError'),);
              }
          return Container();
        }),
      ),
    );
  }
}
