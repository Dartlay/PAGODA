import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Api/api_weather.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';
import 'package:pagoda/Widget/extra_weather.dart';
import 'package:pagoda/Widget/tommorow_extre_weather.dart';

class DetailPage extends StatelessWidget {
  final TomorrowWeatherModel tomorrowTemp;
  final List<SevenDayWeatherModel> sevenDayWeatherdata;
  DetailPage(this.tomorrowTemp, this.sevenDayWeatherdata);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/minimal2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            TomorrowWeather(tomorrowTemp),
            SevenDays(sevenDayWeatherdata)
          ],
        ),
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final TomorrowWeatherModel tomorrowTemp;
  TomorrowWeather(this.tomorrowTemp);

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0xff00A1FF).withOpacity(0.6),
      glowColor: Color(0xff00A1FF).withOpacity(0.6),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " 7 Days",
                      style: TextStyle(
                          fontSize: 110.r, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(tomorrowTemp.image))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tomorrow",
                      style: TextStyle(
                          fontSize: 135.r,
                          fontWeight: FontWeight.bold,
                          height: 0.1),
                    ),
                    Container(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            tomorrowTemp.max.toString(),
                            style: TextStyle(
                                fontSize: 355.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/" + tomorrowTemp.min.toString() + "\u00B0",
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.3),
                                fontSize: 145.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " " + tomorrowTemp.name,
                      style: TextStyle(
                          fontSize: 100.r, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 50,
              left: 50,
            ),
            child: Column(
              children: [
                // Divider(color: Colors.white),
                SizedBox(
                  height: 10,
                ),
                TommorowExtraWeather(tomorrowTemp)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  List<SevenDayWeatherModel> sevenDayWeatherdata;
  SevenDays(this.sevenDayWeatherdata);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount: sevenDayWeatherdata.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sevenDayWeatherdata[index].day,
                          style: TextStyle(fontSize: 20)),
                      Container(
                        width: 135,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image:
                                  AssetImage(sevenDayWeatherdata[index].image),
                              width: 40,
                            ),
                            SizedBox(width: 15),
                            Text(
                              sevenDayWeatherdata[index].name,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "+" +
                                sevenDayWeatherdata[index].max.toString() +
                                "\u00B0",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+" +
                                sevenDayWeatherdata[index].min.toString() +
                                "\u00B0",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
