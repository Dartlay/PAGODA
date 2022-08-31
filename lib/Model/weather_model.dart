import 'package:intl/intl.dart';
import 'package:pagoda/Model/current_weather/current_weather.dart';
import 'package:pagoda/Model/current_weather/current_weather_data.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather_data.dart';
import 'package:pagoda/Model/today_weather/today_weather.dart';
import 'package:pagoda/Model/today_weather/today_weather_data.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather_data.dart';
import 'package:pagoda/Model/weather.dart';
import '../Utilits/find_icon.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required CurrentWeatherData currentWeatherData,
    required SevenDayWeatherData sevenDayWeatherData,
    required TodayWeatherData todayWeatherData,
    required TomorrowWeatherData tomorrowWeatherData,
  }) : super(
          tomorrowWeatherData: tomorrowWeatherData,
          currentWeatherData: currentWeatherData,
          sevenDayWeatherData: sevenDayWeatherData,
          todayWeatherData: todayWeatherData,
        );

  static String _formatLocation(String value) {
    final pos = value.indexOf('/');
    final res = value.replaceRange(0, pos + 1, '');
    return res;
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.now();
    var city = _formatLocation(json["timezone"].toString());
    var current = json["current"];
    var daily = json["daily"][0];
    CurrentWeatherModel currentTemp = CurrentWeatherModel(
      current: current["temp"]?.round() ?? 0,
      name: current["weather"][0]["main"].toString(),
      day: DateFormat("EEEE dd MMMM").format(date),
      wind: current["wind_speed"]?.round() ?? 0,
      humidity: current["humidity"]?.round() ?? 0,
      chanceRain: current["uvi"]?.round() ?? 0,
      location: city,
      image: findIcon(current["weather"][0]["main"].toString(), true),
    );

    List<TodayWeatherModel> todayWeather = [];
    int hour = int.parse(DateFormat("HH").format(date));
    for (var i = 0; i < 4; i++) {
      var temp = json["hourly"];
      var hourly = TodayWeatherModel(
          current: temp[i]["temp"]?.round() ?? 0,
          image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
          time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00");
      todayWeather.add(hourly);
    }
    TomorrowWeatherModel tomorrowTemp = TomorrowWeatherModel(
        max: daily["temp"]["max"]?.round() ?? 0,
        min: daily["temp"]["min"]?.round() ?? 0,
        image: findIcon(daily["weather"][0]["main"].toString(), true),
        name: daily["weather"][0]["main"].toString(),
        wind: daily["wind_speed"]?.round() ?? 0,
        humidity: daily["rain"]?.round() ?? 0,
        chanceRain: daily["uvi"]?.round() ?? 0);

    List<SevenDayWeatherModel> sevenDay = [];
    for (var i = 1; i < 8; i++) {
      String day = DateFormat("EEEE")
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);
      var temp = json["daily"][i];
      var hourly = SevenDayWeatherModel(
        max: temp["temp"]["max"].round() ?? 0,
        min: temp["temp"]["min"].round() ?? 0,
        image: findIcon(temp["weather"][0]["main"].toString(), false),
        name: temp["weather"][0]["main"].toString(),
        day: day,
      );
      sevenDay.add(hourly);
    }

    return WeatherModel(
        tomorrowWeatherData:
            TomorrowWeatherData(tomorrowWeatherData: tomorrowTemp),
        currentWeatherData: CurrentWeatherData(currentWeatherData: currentTemp),
        sevenDayWeatherData: SevenDayWeatherData(sevenDayWeatherdata: sevenDay),
        todayWeatherData: TodayWeatherData(todayWeatherData: todayWeather));
  }
}
