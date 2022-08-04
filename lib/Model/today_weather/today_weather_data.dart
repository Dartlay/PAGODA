import 'package:equatable/equatable.dart';
import 'package:pagoda/Model/today_weather/today_weather.dart';

class TodayWeatherData extends Equatable {
  List<TodayWeatherModel> todayWeatherData;

  TodayWeatherData({required this.todayWeatherData});
  @override
  List<Object?> get props => [todayWeatherData];
}
