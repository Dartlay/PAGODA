part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class WeatherInitializeEvent extends WeatherEvent {}

class WeatherSearchEvent extends WeatherEvent {
  final String cityName;
  WeatherSearchEvent({required this.cityName});
}
