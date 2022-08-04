import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/tomorrow_weather/tomorrow_weather.dart';

class TommorowExtraWeather extends StatelessWidget {
  TomorrowWeatherModel tomorrowTemp;
  TommorowExtraWeather(this.tomorrowTemp, {Key? key}) : super(key: key);

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
              tomorrowTemp.wind.toString() + " Km/h",
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
              tomorrowTemp.humidity.toString() + " %",
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
              tomorrowTemp.chanceRain.toString() + " %",
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
