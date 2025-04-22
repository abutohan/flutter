import 'package:json_annotation/json_annotation.dart';
import 'weather_data.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final String cod;
  final List<WeatherData> list;

  WeatherResponse({required this.cod, required this.list});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
