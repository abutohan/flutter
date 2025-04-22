import 'package:bloc_pattern/apps/weather_app/data/repositories/weather_repository.dart';
import 'package:bloc_pattern/apps/weather_app/presentation/screens/weather_screen.dart';
import 'package:bloc_pattern/bloc/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherMain extends StatelessWidget {
  const WeatherMain({required this.repository, super.key});

  final WeatherRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: BlocProvider(
        create: (context) => WeatherBloc(repository: repository),
        child: const WeatherScreen(),
      ),
    );
  }
}
