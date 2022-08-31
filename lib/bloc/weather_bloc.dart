import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagoda/Model/weather_model.dart';

import '../Utilits/city_model.dart';
import '../repository/weather_repository.dart';

// import 'package:bloc/bloc.dart';
// import 'package:pagoda/Api/api_response.dart';
// import 'package:pagoda/Model/current_weather/current_weather.dart';
// import 'package:pagoda/Model/current_weather/current_weather_data.dart';
// import 'package:pagoda/Model/seven_day_weather/seven_day_weather_data.dart';
// import 'package:pagoda/Model/today_weather/today_weather_data.dart';
// import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';
// import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather_data.dart';
// import 'package:pagoda/Model/weather_model.dart';
// import 'package:pagoda/Screens/HomePage/home.dart';
// import 'package:pagoda/Utilits/city_model.dart';
// import 'package:pagoda/repository/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.repository}) : super(WeatherInitialState()) {
    on<WeatherInitializeEvent>(_onInit);
    on<WeatherChangedEvent>(_onChange);
  }
  final WetherRepository repository;

  bool searchBar = false;
  final bool updating = true;
  final bool error = false;

  FutureOr<void> _onInit(
      WeatherInitializeEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      const cityInitValue = 'Minsk';
      final weather = await repository.fetchData(cityInitValue);
      final city = weather?.currentWeatherData.currentWeatherData.location;

      emit(WeatherLoadedState(
        city: city!,
        weather: weather!,
        error: this.error,
        searchBar: this.searchBar,
      ));
    } catch (e) {
      emit(WeatherErrorState());
    }
  }

  FutureOr<void> _onChange(
      WeatherChangedEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      final weather = await repository.service.fetchData(event.city);
      searchBar = true;
      emit(WeatherLoadedState(
          city: event.city,
          weather: weather!,
          error: error,
          searchBar: !event.searchBar));
    } catch (_) {}
  }
}
