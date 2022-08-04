part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;
  final bool error;
  WeatherLoadedState({required this.weather, required this.error});
}

class WeatherLoadingState extends WeatherState {}
