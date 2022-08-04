import 'package:equatable/equatable.dart';

class TodayWeatherModel extends Equatable {
  int current;
  String time;
  String image;

  TodayWeatherModel({
    required this.current,
    required this.time,
    required this.image,
  });

  @override
  List<Object?> get props => [current, time, image];
}
