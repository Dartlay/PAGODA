import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pagoda/Model/weather_model.dart';
import 'package:pagoda/Utilits/city_model.dart';

class DataService {
  static getInstance() => DataService();

  Future<WeatherModel?> fetchData(String city) async {
    final cityModel = await _fetchCity(city);
    final data = await _fetchDataByCity(cityModel);
    return data;
  }

  Future<WeatherModel?> _fetchDataByCity(CityModel? cityModel) async {
    if (cityModel != null) {
      final response = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/onecall?lat=${cityModel.lat}&lon=${cityModel.lon}&units=metric&appid=cf3f8258706e31556516ee84864061c9"),
      );
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      }
    }
    return null;
  }

  Future<CityModel?> _fetchCity(String cityName) async {
    if (cityJSON == null) {
      String link =
          "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json";
      var response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        cityJSON = json.decode(response.body);
      }
    }
    for (var i = 0; i < cityJSON.length; i++) {
      if (cityJSON[i]["name"].toString().toLowerCase() ==
          cityName.toLowerCase()) {
        return CityModel(
            name: cityJSON[i]["name"].toString(),
            lat: cityJSON[i]["latitude"].toString(),
            lon: cityJSON[i]["longitude"].toString());
      }
    }
    return null;
  }
}
