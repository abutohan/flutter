import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/apps/weather_app/data/models/weather_response.dart';
import 'package:bloc_pattern/apps/weather_app/data/repositories/weather_repository.dart';
import 'package:flutter/foundation.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({required this.repository}) : super(WeatherInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await repository.getCurrentWeather(event.cityName);
        emit(WeatherLoaded(weather: weather));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
