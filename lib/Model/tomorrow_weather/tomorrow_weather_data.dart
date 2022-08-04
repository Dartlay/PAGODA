import 'package:equatable/equatable.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';

class TomorrowWeatherData extends Equatable {
  TomorrowWeatherModel tomorrowWeatherData;

  TomorrowWeatherData({required this.tomorrowWeatherData});

  @override
  List<Object?> get props => [tomorrowWeatherData];
}
