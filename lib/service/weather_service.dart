import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';

class WeatherService {
  static const String _apiKey = '';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _searchCityUrl =
      '$_baseUrl/weather?appid=$_apiKey&units=metric&q=';

  Future<Weather> getWeather(String cityName) async {
    final http.Response response = await http.get(_searchCityUrl + cityName);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to load weather data');
    }
  }
}
