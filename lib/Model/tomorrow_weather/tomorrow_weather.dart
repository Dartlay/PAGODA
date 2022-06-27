import 'package:equatable/equatable.dart';

class Tomorrow_Weather extends Equatable {
  final double max;
  final double min;
  final String image;
  final String name;
  final int humidity;
  final int chanceRain;
  final double wind;
  const Tomorrow_Weather(
      {required this.max,
      required this.min,
      required this.image,
      required this.name,
      required this.humidity,
      required this.chanceRain,
      required this.wind});

  @override
  List<Object?> get props => [max, min, image, name, humidity, chanceRain];
}
