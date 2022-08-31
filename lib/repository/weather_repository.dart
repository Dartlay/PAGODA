import 'package:pagoda/Api/api_response.dart';
import 'package:pagoda/Model/weather_model.dart';
import 'package:pagoda/Utilits/city_model.dart';

class WetherRepository {
  WetherRepository({required this.service});
  DataService service;

  Future<WeatherModel?> fetchData(String cityName) async =>
      service.fetchData(cityName);
}
