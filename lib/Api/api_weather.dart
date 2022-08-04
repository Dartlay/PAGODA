// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:pagoda/Utilits/find_icon.dart';

// class Weather {
//   var max;
//   var min;
//   var current;
//   var name;
//   var day;
//   var wind;
//   var humidity;
//   var chanceRain;
//   var image;
//   var time;
//   var location;

//   Weather(
//       {this.max,
//       this.min,
//       this.name,
//       this.day,
//       this.wind,
//       this.humidity,
//       this.chanceRain,
//       this.image,
//       this.current,
//       this.time,
//       this.location});
// }

// String appId = "cf3f8258706e31556516ee84864061c9";

// Future<List> fetchData(String lat, String lon, String city) async {
//   var url =
//       "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId";
//   var response = await http.get(Uri.parse(url));
//   DateTime date = DateTime.now();
//   if (response.statusCode == 200) {
//     var res = json.decode(response.body);

//     var current = res["current"];
//     Weather currentTemp = Weather(
//         //Конктретная погода
//         current: current["temp"]?.round() ?? 0,
//         name: current["weather"][0]["main"].toString(),
//         day: DateFormat("EEEE dd MMMM").format(date),
//         wind: current["wind_speed"]?.round() ?? 0,
//         humidity: current["humidity"]?.round() ?? 0,
//         chanceRain: current["uvi"]?.round() ?? 0,
//         location: city,
//         image: findIcon(current["weather"][0]["main"].toString(), true));

//     //Погода на сегодня
//     List<Weather> todayWeather = [];
//     int hour = int.parse(DateFormat("HH").format(date));
//     for (var i = 0; i < 4; i++) {
//       var temp = res["hourly"];
//       var hourly = Weather(
//           current: temp[i]["temp"]?.round() ?? 0,
//           image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
//           time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00");
//       todayWeather.add(hourly);
//     }

//     //Погода на сегодня
//     var daily = res["daily"][0];
//     Weather tomorrowTemp = Weather(
//         max: daily["temp"]["max"]?.round() ?? 0,
//         min: daily["temp"]["min"]?.round() ?? 0,
//         image: findIcon(daily["weather"][0]["main"].toString(), true),
//         name: daily["weather"][0]["main"].toString(),
//         wind: daily["wind_speed"]?.round() ?? 0,
//         humidity: daily["rain"]?.round() ?? 0,
//         chanceRain: daily["uvi"]?.round() ?? 0);

//     //Погода на 7 дней
//     List<Weather> sevenDay = [];
//     for (var i = 1; i < 8; i++) {
//       String day = DateFormat("EEEE")
//           .format(DateTime(date.year, date.month, date.day + i + 1))
//           .substring(0, 3);
//       var temp = res["daily"][i];
//       var hourly = Weather(
//           max: temp["temp"]["max"]?.round() ?? 0,
//           min: temp["temp"]["min"]?.round() ?? 0,
//           image: findIcon(temp["weather"][0]["main"].toString(), false),
//           name: temp["weather"][0]["main"].toString(),
//           day: day);
//       sevenDay.add(hourly);
//     }
//     return [currentTemp, todayWeather, tomorrowTemp, sevenDay];
//   }
//   return [null, null, null, null];
// }
