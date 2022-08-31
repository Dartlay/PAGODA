part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class WeatherInitializeEvent extends WeatherEvent {}

class WeatherloadedEvent extends WeatherEvent {}

class WeatherChangedEvent extends WeatherEvent {
  WeatherChangedEvent({
    required this.searchBar,
    required this.city,
  });

  final String city;
  final bool searchBar;
}
