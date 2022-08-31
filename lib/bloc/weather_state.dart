part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final String city;
  final WeatherModel weather;
  final bool error;
  bool searchBar;

  WeatherLoadedState({
    required this.city,
    required this.weather,
    required this.error,
    required this.searchBar,
  });

  WeatherLoadedState copyWith({
    String? city,
    WeatherModel? weather,
    bool? error,
    bool? searchBar,
  }) =>
      WeatherLoadedState(
        city: city ?? this.city,
        weather: weather ?? this.weather,
        error: error ?? this.error,
        searchBar: searchBar ?? this.searchBar,
      );
}

class WeatherErrorState extends WeatherState {}
