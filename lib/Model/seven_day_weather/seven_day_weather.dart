import 'package:equatable/equatable.dart';

class SevenDayWeatherModel extends Equatable {
  int max;
  int min;
  String name;
  String day;
  String image;

  SevenDayWeatherModel({
    required this.max,
    required this.min,
    required this.name,
    required this.day,
    required this.image,
  });

  @override
  List<Object?> get props => [max, min, name, day, image];
}
