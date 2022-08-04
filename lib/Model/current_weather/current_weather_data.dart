import 'package:equatable/equatable.dart';
import 'package:pagoda/Model/current_weather/current_weather.dart';

class CurrentWeatherData extends Equatable {
  CurrentWeatherModel currentWeatherData;

  CurrentWeatherData({required this.currentWeatherData});

  @override
  List<Object?> get props => [currentWeatherData];
}
