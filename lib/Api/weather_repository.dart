// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:pagoda/Screens/HomePage/home.dart';
// import 'package:pagoda/Utilits/find_icon.dart';
// import '../Utilits/find_icon.dart';
// class Weather_Repository {
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
// Weather_Repository({
// this.chanceRain,
// this.current,
// this.day,
// this.humidity,
// this.image,
// this.location,
// this.max,
// this.min,
// this.name,
// this.time,
// this.wind
// })

//    factory Weather_Repository.fromJson(Map<String, dynamic> json){
//     print(json);
    
//     DateTime date = DateTime.now(); //Конктретная погода
//     var res;
//     var current = res["current"];
//     Weather_Repository currentTemp = Weather_Repository(
//         current: current["temp"]?.round() ?? 0,
//         name: current["weather"][0]["main"].toString(),
//         day: DateFormat("EEEE dd MMMM").format(date),
//         wind: current["wind_speed"]?.round() ?? 0,
//         humidity: current["humidity"]?.round() ?? 0,
//         chanceRain: current["uvi"]?.round() ?? 0,
//         location: city,
//         image: findIcon(current["weather"][0]["main"].toString(), true));

//     //Погода на сегодня
//     List<Weather_Repository> todayWeather = [];
//     int hour = int.parse(DateFormat("hh").format(date));
//     for (var i = 0; i < 4; i++) {
//       var temp = res["hourly"];
//       var hourly = Weather_Repository(
//           current: temp[i]["temp"]?.round() ?? 0,
//           image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
//           time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00");
//       todayWeather.add(hourly);
//     }

//    //Погода на сегодня
//     var daily = res["daily"][0];
//     Weather_Repository tomorrowTemp = Weather_Repository(
//         max: daily["temp"]["max"]?.round() ?? 0,
//         min: daily["temp"]["min"]?.round() ?? 0,
//         image: findIcon(daily["weather"][0]["main"].toString(), true),
//         name: daily["weather"][0]["main"].toString(),
//         wind: daily["wind_speed"]?.round() ?? 0,
//         humidity: daily["rain"]?.round() ?? 0,
//         chanceRain: daily["uvi"]?.round() ?? 0);

//     //Погода на 7 дней
//     List<Weather_Repository> sevenDay = [];
//     for (var i = 1; i < 8; i++) {
//       String day = DateFormat("EEEE")
//           .format(DateTime(date.year, date.month, date.day + i + 1))
//           .substring(0, 3);
//       var temp = res["daily"][i];
//       var hourly = Weather_Repository(
//           max: temp["temp"]["max"]?.round() ?? 0,
//           min: temp["temp"]["min"]?.round() ?? 0,
//           image: findIcon(temp["weather"][0]["main"].toString(), false),
//           name: temp["weather"][0]["main"].toString(),
//           day: day);
//       sevenDay.add(hourly);
//     }
//      return [currentTemp, todayWeather, tomorrowTemp, sevenDay];
//   } 
// }