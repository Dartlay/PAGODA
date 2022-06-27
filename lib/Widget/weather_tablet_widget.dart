import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Api/api_weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.h,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 125, 131, 129).withOpacity(0.5),
          border:
              Border.all(width: 0.9, color: Color.fromARGB(255, 252, 252, 252)),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            weather.current.toString() + "\u00B0",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(75),
                color: Color.fromARGB(255, 255, 254, 254)),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(weather.image),
            width: 158.w,
            height: 158.h,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather.time,
            style:
                TextStyle(fontSize: 16, color: Color.fromARGB(255, 14, 1, 1)),
          )
        ],
      ),
    );
  }
}
