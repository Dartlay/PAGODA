import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pagoda/Widget/tommorow_extre_weather.dart';
import 'package:pagoda/bloc/weather_bloc.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final WeatherBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = context.read<WeatherBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/minimal2.png'),
                )),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 244, 248, 249),
                )),
              );
            }
            if (state is WeatherLoadedState) {
              return _buildLoadedState(state, _bloc);
            } else {
              return Container();
            }
          },
        ),
      );

  @override
  Widget _buildLoadedState(WeatherLoadedState state, WeatherBloc bloc) {
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
            TomorrowWeather(
              state: state,
            ),
            SizedBox(
              height: 50.h,
            ),
            SevenDays(
              state: state,
            )
          ],
        ),
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  TomorrowWeather({required this.state});
  final WeatherLoadedState state;

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
            padding:
                EdgeInsets.only(top: 50, right: 60, left: 60, bottom: 60).r,
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
                          image: AssetImage(state.weather.tomorrowWeatherData
                              .tomorrowWeatherData.image))),
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
                            state.weather.tomorrowWeatherData
                                .tomorrowWeatherData.max
                                .toString(),
                            style: TextStyle(
                                fontSize: 355.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/" +
                                state.weather.tomorrowWeatherData
                                    .tomorrowWeatherData.min
                                    .toString() +
                                "\u00B0",
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
                      " " +
                          state.weather.tomorrowWeatherData.tomorrowWeatherData
                              .name,
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
                TommorowExtraWeather(state)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  SevenDays({required this.state});
  final WeatherLoadedState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount:
                state.weather.sevenDayWeatherData.sevenDayWeatherdata.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.only(left: 70, right: 70, bottom: 150).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          state.weather.sevenDayWeatherData
                              .sevenDayWeatherdata[index].day,
                          style: TextStyle(fontSize: 84.sp)),
                      Container(
                        width: 135,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(state
                                  .weather
                                  .sevenDayWeatherData
                                  .sevenDayWeatherdata[index]
                                  .image),
                              width: 160.w,
                            ),
                            SizedBox(width: 30.w),
                            Text(
                              state.weather.sevenDayWeatherData
                                  .sevenDayWeatherdata[index].name,
                              style: TextStyle(fontSize: 84.sp),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "+" +
                                state.weather.sevenDayWeatherData
                                    .sevenDayWeatherdata[index].max
                                    .toString() +
                                "\u00B0",
                            style: TextStyle(fontSize: 80.sp),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+" +
                                state.weather.sevenDayWeatherData
                                    .sevenDayWeatherdata[index].min
                                    .toString() +
                                "\u00B0",
                            style:
                                TextStyle(fontSize: 70.sp, color: Colors.grey),
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
