import 'package:bloc_pattern/apps/weather_app/secrets.dart';
import 'package:dio/dio.dart';

import '../datasources/weather_api_client.dart';
import '../models/weather_response.dart';

class WeatherRepository {
  final WeatherApiClient apiClient;

  WeatherRepository({required this.apiClient});

  Future<WeatherResponse> getCurrentWeather(String cityName) async {
    try {
      final response = await apiClient.getWeatherForecast(
        cityName,
        openWeatherAPIKey,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load weather: ${e.message}');
    }
  }
}
