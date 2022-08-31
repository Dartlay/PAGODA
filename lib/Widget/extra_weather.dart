import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Api/api_weather.dart';
import 'package:pagoda/Model/current_weather/current_weather.dart';
import 'package:pagoda/bloc/weather_bloc.dart';

class ExtraWeather extends StatelessWidget {
  ExtraWeather(this.state);
  final WeatherLoadedState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
              size: 91.sp,
            ),
            SizedBox(
              height: 19.h,
            ),
            Text(
              state.weather.currentWeatherData.currentWeatherData.wind
                      .toString() +
                  " Km/h",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 59.sp),
            ),
            SizedBox(
              height: 19.h,
            ),
            Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 59.sp),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.drop,
              color: Colors.white,
              size: 91.sp,
            ),
            SizedBox(
              height: 19.h,
            ),
            Text(
              state.weather.currentWeatherData.currentWeatherData.humidity
                      .toString() +
                  " %",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 59.sp),
            ),
            SizedBox(
              height: 19.h,
            ),
            Text(
              "Humidity",
              style: TextStyle(color: Colors.black54, fontSize: 59.sp),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.cloud_rain,
              color: Colors.white,
              size: 91.sp,
            ),
            SizedBox(
              height: 19.h,
            ),
            Text(
              state.weather.currentWeatherData.currentWeatherData.chanceRain
                      .toString() +
                  " %",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 59.sp),
            ),
            SizedBox(
              height: 19.h,
            ),
            Text(
              "Rain",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setSp(59)),
            )
          ],
        )
      ],
    );
  }
}
