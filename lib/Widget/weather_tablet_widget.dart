import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Api/api_weather.dart';
import 'package:pagoda/Model/today_weather/today_weather.dart';

class WeatherWidget extends StatelessWidget {
  TodayWeatherModel todayWeatherModel;
  WeatherWidget(this.todayWeatherModel);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlowContainer(
        height: 430.h,
        padding: EdgeInsets.all(15),
        glowColor: Color.fromARGB(255, 147, 212, 235).withOpacity(0.6),
        border: Border.all(
            width: 0.9,
            color: Color.fromARGB(255, 252, 252, 252).withOpacity(0.6)),
        borderRadius: BorderRadius.circular(35),
        color: Color.fromARGB(255, 147, 212, 235).withOpacity(0.6),
        spreadRadius: 15.r,
        child: Column(
          children: [
            Text(
              todayWeatherModel.current.toString() + "\u00B0",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(75),
                  color: Color.fromARGB(255, 255, 254, 254)),
            ),
            SizedBox(
              height: 5,
            ),
            Image(
              image: AssetImage(todayWeatherModel.image),
              width: 158.w,
              height: 158.h,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              todayWeatherModel.time,
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
    );
  }
}
