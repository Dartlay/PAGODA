import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pagoda/Api/api_response.dart';
import 'package:pagoda/Screens/HomePage/home.dart';
import 'package:flutter/services.dart';
import 'package:pagoda/bloc/weather_bloc.dart';
import 'package:pagoda/repository/weather_repository.dart';

void main() {
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.bottom]);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => WeatherBloc(
        repository: WetherRepository(
          service: DataService.getInstance(),
        ),
      ),
    )
  ], child: Pogodka()));
}

class Pogodka extends StatefulWidget {
  @override
  State<Pogodka> createState() => _PogodkaState();
}

class _PogodkaState extends State<Pogodka> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pogodka',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        designSize: const Size(1440, 2560),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return Home();
        },
      ),
    );
  }
}
