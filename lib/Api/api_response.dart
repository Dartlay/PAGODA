import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pagoda/Model/weather_model.dart';

class Api {
  Future<WeatherModel> fetchData(String lat, String lon, String city) async {
    var url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=cf3f8258706e31556516ee84864061c9";
    var response = await http.get(Uri.parse(url));
    DateTime date = DateTime.now();
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
    }
    return fetchData(lat, lon, city);
  }
}
