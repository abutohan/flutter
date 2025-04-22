import 'package:bloc_pattern/apps/weather_app/data/models/weather_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'weather_api_client.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5/")
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET('forecast')
  Future<WeatherResponse> getWeatherForecast(
    @Query('q') String cityName,
    @Query('APPID') String apiKey,
  );
}
