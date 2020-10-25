import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather/model/weather.dart';

class WeatherService {
  static const String _apiKey = '';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?appid=$_apiKey&units=metric';

  final Client _client;

  WeatherService(this._client);

  String getWeatherByCityNameUrl(String cityName) => '$_baseUrl&q=$cityName';

  String getWeatherByCoordinatesUrl(double latitude, double longitude) =>
      '$_baseUrl&lat=$latitude&lon=$longitude';

  Future<Weather> getWeatherByCityName(String cityName) =>
      _getWeather(getWeatherByCityNameUrl(cityName));

  Future<Weather> getWeatherByCoordinates(double latitude, double longitude) =>
      _getWeather(getWeatherByCoordinatesUrl(latitude, longitude));

  Future<Weather> getWeatherByCurrentLocation() async {
    final position = await _getCurrentLocation();
    return getWeatherByCoordinates(position.latitude, position.longitude);
  }

  Future<Weather> _getWeather(String searchUrl) async {
    final response = await _client.get(searchUrl);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Unable to load weather data');
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool isLocationServiceAvailable =
        await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceAvailable) {
      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } else {
      throw 'Location service is disabled';
    }
  }
}
