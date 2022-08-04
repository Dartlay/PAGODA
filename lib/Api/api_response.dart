import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pagoda/Model/weather_model.dart';

class DataService {
  Future<WeatherModel> fetchData(String lat, String lon, String city) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=cf3f8258706e31556516ee84864061c9"),
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    }
    return fetchData(lat, lon, city);
  }
}
