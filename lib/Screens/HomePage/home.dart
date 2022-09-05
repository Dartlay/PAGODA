import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Screens/DetalPage/detail_page_home.dart';
import 'package:pagoda/Utilits/city_model.dart';
import 'package:pagoda/Widget/extra_weather.dart';
import 'package:pagoda/Widget/weather_tablet_widget.dart';
import 'package:pagoda/bloc/weather_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final WeatherBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = context.read<WeatherBloc>()
      ..add(
        WeatherInitializeEvent(),
      );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/minimal.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1100).r,
                    child: Column(children: [
                      Text("Please wait for it",
                          style: TextStyle(
                              height: 0.1.h,
                              fontSize: 100.sp,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 120).r,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 244, 248, 249),
                          ),
                        ),
                      ),
                    ]),
                  ));
            }
            if (state is WeatherLoadedState) {
              return _buildLoadedState(state, _bloc);
            } else {
              return Container();
            }
          },
        ),
      );

  Widget _buildLoadedState(WeatherLoadedState state, WeatherBloc bloc) {
    return Column(children: [
      Container(
        width: 1440.w,
        height: 2560.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/minimal.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Currentweather(
            state: state,
            bloc: bloc,
          ),
          TodayWeather(
            state: state,
          )
        ]),
      ),
    ]);
  }
}

class Currentweather extends StatefulWidget {
  Currentweather({
    required this.state,
    required this.bloc,
  });

  final WeatherLoadedState state;
  final WeatherBloc bloc;

  @override
  State<Currentweather> createState() => _CurrentweatherState();
}

class _CurrentweatherState extends State<Currentweather> {
  bool searchBar = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchBar) {
          setState(() {
            searchBar = false;
          });
        }
      },
      child: GlowContainer(
        height: MediaQuery.of(context).size.height - 250,
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.only(top: 40, left: 50, right: 50).r,
        glowColor: Color.fromARGB(255, 147, 212, 235).withOpacity(0.6),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: Color.fromARGB(255, 147, 212, 235).withOpacity(0.6),
        spreadRadius: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
                        CityModel? temp =
                            await fetchCity(value.replaceAll(' ', ''));
                        if (temp == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color.fromARGB(255, 8, 3, 3),
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

                        setState(() {
                          searchBar = false;
                        });
                        widget.bloc.add(
                          WeatherChangedEvent(
                            city: value.replaceAll(' ', ''),
                            searchBar: searchBar,
                          ),
                        );
                      })
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
                                  setState(() {
                                    searchBar = true;
                                  });

                                  focusNode.requestFocus();
                                },
                                child: Text(
                                  " " +
                                      widget.state.weather.currentWeatherData
                                          .currentWeatherData.location,
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

            // Padding(
            //   padding: const EdgeInsets.only(top: 20).r,
            //   child: Container(
            //     height: 120.h,
            //     padding: EdgeInsets.all(35).r,
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 0.9, color: Colors.white),
            //         borderRadius: BorderRadius.circular(30)),
            //     child: Text(
            //       updating ? "Updating" : "Updated",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            Container(
              height: 1200.h,
              width: 1100.w,
              child: Column(
                children: [
                  Image(
                    image: AssetImage(widget.state.weather.currentWeatherData
                        .currentWeatherData.image),
                    fit: BoxFit.contain,
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 40).r,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 300, right: 300).r,
                          child: Text(
                            widget.state.weather.currentWeatherData
                                .currentWeatherData.current
                                .toString(),
                            style: TextStyle(
                                height: 0.1.h,
                                fontSize: 355.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                            widget.state.weather.currentWeatherData
                                .currentWeatherData.name,
                            style: TextStyle(
                              fontSize: 110.sp,
                            )),
                        Text(
                            widget.state.weather.currentWeatherData
                                .currentWeatherData.day,
                            style: TextStyle(
                              fontSize: 100.sp,
                            )),
                      ],
                    ),
                  )),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60).r,
              child: ExtraWeather(widget.state),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  TodayWeather({required this.state});
  final WeatherLoadedState state;
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
                      return DetailPage();
                    }));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25).r,
                        child: Text(
                          "7 Days ",
                          style: TextStyle(
                              fontSize: 92.sp,
                              fontWeight: FontWeight.bold,
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
                        child: WeatherWidget(
                            state.weather.todayWeatherData.todayWeatherData[0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20).r,
                        child: WeatherWidget(
                            state.weather.todayWeatherData.todayWeatherData[1]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20).r,
                        child: WeatherWidget(
                            state.weather.todayWeatherData.todayWeatherData[2]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 90, top: 20).r,
                        child: WeatherWidget(
                            state.weather.todayWeatherData.todayWeatherData[3]),
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
