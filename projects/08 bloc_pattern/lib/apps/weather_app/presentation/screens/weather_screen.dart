import 'dart:ui';
import 'package:bloc_pattern/apps/weather_app/presentation/widgets/additional_info_item.dart';
import 'package:bloc_pattern/apps/weather_app/presentation/widgets/hourly_forecast_item.dart';
import 'package:bloc_pattern/bloc/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherEvent(cityName: "Manila"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(
                FetchWeatherEvent(cityName: "Manila"),
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        // future: weather,
        builder: (context, state) {
          if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          if (state is! WeatherLoaded) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final data = state.weather.list;
          final currentTemp = data[0].main.temp;
          final currentSky = data[0].weather[0].description;
          final currentPressure = data[0].main.pressure;
          final currentWindSpeed = data[0].wind.speed;
          final currentHumidity = data[0].main.humidity;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '${(currentTemp - 273.15).toInt()} °C',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data[index];
                      final hourlySky = data[index].weather[0].main;
                      final hourlyTemp = hourlyForecast.main.temp;
                      final time = DateTime.parse(hourlyForecast.dateText);
                      return HourlyForecastItem(
                        time: DateFormat.j().format(time),
                        temperature: "${(hourlyTemp - 273.15).toInt()} °C",
                        icon:
                            hourlySky == 'Clouds' || hourlySky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
