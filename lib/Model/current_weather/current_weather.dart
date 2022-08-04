import 'package:equatable/equatable.dart';

class CurrentWeatherModel extends Equatable {
  int current;
  String name;
  String day;
  int wind;
  int humidity;
  int chanceRain;
  String image;
  String location;

  CurrentWeatherModel(
      {required this.current,
      required this.name,
      required this.day,
      required this.wind,
      required this.humidity,
      required this.chanceRain,
      required this.image,
      required this.location});

  @override
  List<Object?> get props =>
      [current, name, day, wind, humidity, chanceRain, image, location];
}
