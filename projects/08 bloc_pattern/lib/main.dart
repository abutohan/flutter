import 'package:bloc_pattern/apps/weather_app/data/datasources/weather_api_client.dart';
import 'package:bloc_pattern/apps/weather_app/data/repositories/weather_repository.dart';
import 'package:bloc_pattern/apps/weather_app/weather_main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  // Bloc.observer = AuthBlocObserver();
  final dio = Dio();
  final weatherApiClient = WeatherApiClient(dio);
  final weatherRepository = WeatherRepository(apiClient: weatherApiClient);
  runApp(WeatherMain(repository: weatherRepository));
}
