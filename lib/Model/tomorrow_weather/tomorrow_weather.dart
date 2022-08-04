import 'package:equatable/equatable.dart';

class TomorrowWeatherModel extends Equatable {
  var max;
  var min;
  var image;
  var name;
  var humidity;
  var chanceRain;
  var wind;
  TomorrowWeatherModel(
      {required this.max,
      required this.min,
      required this.image,
      required this.name,
      required this.humidity,
      required this.chanceRain,
      required this.wind});

  @override
  List<Object?> get props =>
      [max, min, image, name, humidity, chanceRain, wind];
}
