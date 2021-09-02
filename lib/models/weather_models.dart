// {
//     "weather": [{
//             "description": "overcast clouds",
//             "icon": "04d"
//     }],
//     "main": {
//         "temp": 302.8
//     },
//     "name": "Thailand"
// }
class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.formJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.formJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class Weather {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl =>
      'https://openweathermap.org/img/wn/${weatherInfo.icon}@4x.png';

  Weather(
      {required this.cityName,
      required this.tempInfo,
      required this.weatherInfo});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.formJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.formJson(weatherInfoJson);

    return Weather(
        cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo);
  }
}
