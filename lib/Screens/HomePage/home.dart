import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Model/current_weather/current_weather.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather.dart';

import 'package:pagoda/Model/today_weather/today_weather_data.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';
import 'package:pagoda/Screens/DetalPage/detail_page_home.dart';
import 'package:pagoda/Utilits/city_model.dart';
import 'package:pagoda/Widget/extra_weather.dart';
import 'package:pagoda/Widget/weather_tablet_widget.dart';

Weather? currentTemp;
Weather tomorrowTemp = Weather();
List<Weather>? todayWeather;
List<Weather>? sevenDay;
String lat = "53.9006";
String lon = "27.5590";
String city = "Minisk";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Function()? get updateData => null;

  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: 1440.w,
        height: 2560.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/minimal.png'),
            fit: BoxFit.cover,
          ),
        ),
        // ignore: unnecessary_null_comparison
        child: currentTemp == null
            ? Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 147, 212, 235),
                ),
              )
            : Column(children: [Currentweather(getData), TodayWeather()]),
      ),
    );
  }
}

class Currentweather extends StatefulWidget {
  final Function() updateData;
  Currentweather(this.updateData);
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<Currentweather> {
  bool searchBar = false;
  bool updating = true;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchBar)
          setState(() {
            searchBar = false;
          });
      },
      child: GlowContainer(
          height: MediaQuery.of(context).size.height - 250,
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.only(top: 40, left: 50, right: 50).r,
          glowColor: Color.fromARGB(255, 147, 212, 235).withOpacity(0.6),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
          color: Color.fromARGB(255, 147, 212, 235).withOpacity(0.6),
          spreadRadius: 5,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.only(top: 70).r,
              child: Container(
                child: searchBar
                    ? TextField(
                        style: TextStyle(color: Colors.black),
                        focusNode: focusNode,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            filled: true,
                            hintText: "Enter a city Name",
                            hintStyle: TextStyle(color: Colors.black)),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) async {
                          CityModel? temp = await fetchCity(value);
                          if (temp == null) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 8, 3, 3),
                                    title: Text("City not found"),
                                    content: Text("Please check the city name"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );
                                });
                            searchBar = false;
                            return;
                          }
                          city = temp.name;
                          lat = temp.lat;
                          lon = temp.lon;
                          updating = true;

                          setState(() {});
                          widget.updateData();
                          searchBar = false;
                          updating = false;
                          setState(() {});
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 0, top: 20).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.map_fill,
                                  color: Colors.white,
                                  size: 120.sp,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    searchBar = true;
                                    setState(() {});
                                    focusNode.requestFocus();
                                  },
                                  child: Text(
                                    " " + city,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(170)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20).r,
              child: Container(
                height: 120.h,
                padding: EdgeInsets.all(35).r,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.9, color: Colors.white),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  updating ? "Updating" : "Updated",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 1100.h,
              width: 1100.w,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(currentTemp!.image),
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1000).r,
                    child: Center(
                        child: Column(
                      children: [
                        GlowText(
                          currentTemp!.current.toString(),
                          style: TextStyle(
                              height: 0.1.h,
                              fontSize: 355.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8).r,
                          child: Text(currentTemp!.name,
                              style: TextStyle(
                                fontSize: 110.sp,
                              )),
                        ),
                        Text(currentTemp!.day,
                            style: TextStyle(
                              fontSize: 100.sp,
                            ))
                      ],
                    )),
                  ),
                ],
              ),
            ),

            // SizedBox(
            //   height:
            // }

            ExtraWeather(currentTemp!),
          ])),
    );
  }
}

class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50).r,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 90, top: 25).r,
                  child: Text(
                    "Today",
                    style:
                        TextStyle(fontSize: 92.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DetailPage(tomorrowTemp, sevenDay!);
                    }));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25).r,
                        child: Text(
                          "7 days ",
                          style: TextStyle(
                              fontSize: 92.sp,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 95, top: 25).r,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey,
                          size: 92.sp,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60).r,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 30,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 90, top: 20).r,
                        child: WeatherWidget(todayWeather![0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20).r,
                        child: WeatherWidget(todayWeather![1]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20).r,
                        child: WeatherWidget(todayWeather![2]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 90, top: 20).r,
                        child: WeatherWidget(todayWeather![3]),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
