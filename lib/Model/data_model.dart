import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  var max;
  var min;
  var current;
  var name;
  var day;
  var wind;
  var humidity;
  var chanceRain;
  var image;
  var time;
  var location;

  Weather({
    this.max,
    this.min,
    this.name,
    this.day,
    this.wind,
    this.humidity,
    this.chanceRain,
    this.image,
    this.current,
    this.time,
    this.location,
  });
}

String appId = "cf3f8258706e31556516ee84864061c9";

Future<List> fetchData(String lat, String lon, String city) async {
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    //Конктретная погода
    var current = res["current"];
    Weather currentTemp = Weather(
        current: current["temp"]?.round() ?? 0,
        name: current["weather"][0]["main"].toString(),
        day: DateFormat("EEEE dd MMMM").format(date),
        wind: current["wind_speed"]?.round() ?? 0,
        humidity: current["humidity"]?.round() ?? 0,
        chanceRain: current["uvi"]?.round() ?? 0,
        location: city,
        image: findIcon(current["weather"][0]["main"].toString(), true));

    //Погода на сегодня
    List<Weather> todayWeather = [];
    int hour = int.parse(DateFormat("hh").format(date));
    for (var i = 0; i < 4; i++) {
      var temp = res["hourly"];
      var hourly = Weather(
          current: temp[i]["temp"]?.round() ?? 0,
          image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
          time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00");
      todayWeather.add(hourly);
    }

    //Ежедневная погода
    var daily = res["daily"][0];
    Weather tomorrowTemp = Weather(
        max: daily["temp"]["max"]?.round() ?? 0,
        min: daily["temp"]["min"]?.round() ?? 0,
        image: findIcon(daily["weather"][0]["main"].toString(), true),
        name: daily["weather"][0]["main"].toString(),
        wind: daily["wind_speed"]?.round() ?? 0,
        humidity: daily["rain"]?.round() ?? 0,
        chanceRain: daily["uvi"]?.round() ?? 0);

    //Погода на 7 дней
    List<Weather> sevenDay = [];
    for (var i = 1; i < 8; i++) {
      String day = DateFormat("EEEE")
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);
      var temp = res["daily"][i];
      var hourly = Weather(
          max: temp["temp"]["max"]?.round() ?? 0,
          min: temp["temp"]["min"]?.round() ?? 0,
          image: findIcon(temp["weather"][0]["main"].toString(), false),
          name: temp["weather"][0]["main"].toString(),
          day: day);
      sevenDay.add(hourly);
    }
    return [currentTemp, todayWeather, tomorrowTemp, sevenDay];
  }
  return [null, null, null, null];
}

//Иконки
String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "assets/sunny.png";

      case "Rain":
        return "assets/rainy.png";

      case "Drizzle":
        return "assets/rainy.png";

      case "Thunderstorm":
        return "assets/thunder.png";

      case "Snow":
        return "assets/snow.png";

      default:
        return "assets/sunny.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/sunny_2d.png";

      case "Rain":
        return "assets/rainy_2d.png";

      case "Drizzle":
        return "assets/rainy_2d.png";

      case "Thunderstorm":
        return "assets/thunder_2d.png";

      case "Snow":
        return "assets/snow_2d.png";

      default:
        return "assets/sunny_2d.png";
    }
  }
}

//Модель городов
class CityModel {
  final String? name;
  final String? lat;
  final String? lon;
  CityModel({this.name, this.lat, this.lon});
}

var cityJSON;

Future<CityModel?> fetchCity(String cityName) async {
  if (cityJSON == null) {
    String link =
        "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json";
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      cityJSON = json.decode(response.body);
    }
  }
  for (var i = 0; i < cityJSON.length; i++) {
    if (cityJSON[i]["name"].toString().toLowerCase() ==
        cityName.toLowerCase()) {
      return CityModel(
          name: cityJSON[i]["name"].toString(),
          lat: cityJSON[i]["latitude"].toString(),
          lon: cityJSON[i]["longitude"].toString());
    }
  }
  return null;
}
