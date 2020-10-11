import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';

class WeatherService {
  static const String _apiKey = '';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?appid=$_apiKey&units=metric';

  Future<Weather> getWeatherByCityName(String cityName) =>
      _getWeather('$_baseUrl&q=$cityName');

  Future<Weather> getWeatherByCoordinates(double latitude, double longitude) =>
      _getWeather('$_baseUrl&lat=$latitude&lon=$longitude');

  Future<Weather> _getWeather(String searchUrl) async {
    final http.Response response = await http.get(searchUrl);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to load weather data');
    }
  }
}
