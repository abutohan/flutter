import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  final Main main;
  final List<Weather> weather;
  final Wind wind;
  @JsonKey(name: 'dt_txt')
  final String dateText;

  WeatherData({
    required this.main,
    required this.weather,
    required this.wind,
    required this.dateText,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}

@JsonSerializable()
class Main {
  final double temp;
  final double humidity;
  final double pressure;

  Main({required this.temp, required this.humidity, required this.pressure});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@JsonSerializable()
class Weather {
  final String main;
  final String description;

  Weather({required this.main, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable()
class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
