import 'package:equatable/equatable.dart';
import 'package:pagoda/Model/current_weather/current_weather_data.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather_data.dart';
import 'package:pagoda/Model/today_weather/today_weather_data.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather_data.dart';

class Weather extends Equatable {
  CurrentWeatherData currentWeatherData;
  SevenDayWeatherData sevenDayWeatherData;
  TodayWeatherData todayWeatherData;
  TomorrowWeatherData tomorrowWeatherData;
  Weather(
      {required this.currentWeatherData,
      required this.sevenDayWeatherData,
      required this.todayWeatherData,
      required this.tomorrowWeatherData});

  @override
  List<Object?> get props => [
        currentWeatherData,
        sevenDayWeatherData,
        todayWeatherData,
        tomorrowWeatherData,
      ];
}
