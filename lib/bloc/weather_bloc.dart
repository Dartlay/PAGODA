import 'package:bloc/bloc.dart';
import 'package:pagoda/Api/api_response.dart';
import 'package:pagoda/Model/current_weather/current_weather.dart';
import 'package:pagoda/Model/current_weather/current_weather_data.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather.dart';
import 'package:pagoda/Model/seven_day_weather/seven_day_weather_data.dart';
import 'package:pagoda/Model/today_weather/today_weather.dart';
import 'package:pagoda/Model/today_weather/today_weather_data.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather.dart';
import 'package:pagoda/Model/tomorrow_weather/tomorrow_weather_data.dart';
import 'package:pagoda/Model/weather_model.dart';
import 'package:pagoda/Screens/HomePage/home.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    final service = DataService();
    var _currentWeatherData = CurrentWeatherData(
        currentWeatherData: CurrentWeatherModel(
      current: 0,
      name: "",
      day: "",
      wind: 0,
      humidity: 0,
      chanceRain: 0,
      location: "",
      image: "",
    ));
    var _sevenDayWeatherData = SevenDayWeatherData(sevenDayWeatherdata: []);
    var _todayWeatherData = TodayWeatherData(todayWeatherData: []);
    var _tomorrowWeatherData = TomorrowWeatherData(
        tomorrowWeatherData: TomorrowWeatherModel(
            max: 0.0,
            min: 0.0,
            image: "",
            name: "",
            humidity: 0,
            chanceRain: 0,
            wind: 0));
    var _weatherModel = WeatherModel(
        currentWeatherData: _currentWeatherData,
        sevenDayWeatherData: _sevenDayWeatherData,
        todayWeatherData: _todayWeatherData,
        tomorrowWeatherData: _tomorrowWeatherData);
    on<WeatherInitializeEvent>((event, emit) async {
      // Function()? get;

      await service.fetchData(lat, lon, city).then((value) {
        currentWeather = value.currentWeatherData.currentWeatherData;
        todayWeatherData = value.todayWeatherData.todayWeatherData;
        tomorrowTemp = value.tomorrowWeatherData.tomorrowWeatherData;
        sevenDayWeatherdata = value.sevenDayWeatherData.sevenDayWeatherdata;
      });

      emit(WeatherLoadedState(
          weather: WeatherModel(
              currentWeatherData: _currentWeatherData,
              sevenDayWeatherData: _sevenDayWeatherData,
              todayWeatherData: _todayWeatherData,
              tomorrowWeatherData: _tomorrowWeatherData),
          error: false));
    });
  }

  // fetchData(String lat, String lon, String city) {}
}
