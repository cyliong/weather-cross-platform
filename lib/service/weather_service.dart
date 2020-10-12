import 'dart:convert';

import 'package:geolocator/geolocator.dart';
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

  Future<Weather> getWeatherByCurrentLocation() async {
    final position = await _getCurrentLocation();
    return getWeatherByCoordinates(position.latitude, position.longitude);
  }

  Future<Weather> _getWeather(String searchUrl) async {
    final http.Response response = await http.get(searchUrl);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw 'Unable to load weather data';
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool isLocationServiceAvailable = await isLocationServiceEnabled();
    if (isLocationServiceAvailable) {
      return getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    } else {
      throw 'Location service is disabled';
    }
  }
}
