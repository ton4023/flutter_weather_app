import 'dart:convert';
import 'package:flutter_application_1/models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  Future<Weather> getWeather() async {
    final queryParameters = {
      'q': 'Songkhla',
      'appid': '52c3e90f55f196c4156176651e0a5696'
    };

    final uri = Uri.https(
        'api.openweathermap.org', 'data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    return Weather.fromJson(jsonDecode(response.body));
  }
}
