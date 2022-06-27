import 'package:equatable/equatable.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';

class Tomorrow_WeatherData extends Equatable {
  final Tomorrow_Weather tomorrowWeatherData;

  const Tomorrow_WeatherData({required this.tomorrowWeatherData});

  @override
  List<Object?> get props => [tomorrowWeatherData];
}
