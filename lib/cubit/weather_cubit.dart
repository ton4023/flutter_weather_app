import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/weather_models.dart';
import 'package:flutter_application_1/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository}) : super(WeatherInitial());

  void getWeatherData() async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getWeather();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e));
    }
  }
}
