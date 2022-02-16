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

  static WeatherService? _instance;
  factory WeatherService(Client client) =>
      _instance ?? WeatherService._(client);
  WeatherService._(this._client);

  String getWeatherUrlByCityName(String cityName) => '$_baseUrl&q=$cityName';

  String getWeatherUrlByCoordinates(double latitude, double longitude) =>
      '$_baseUrl&lat=$latitude&lon=$longitude';

  Future<Weather> getWeatherByCityName(String cityName) =>
      _getWeather(getWeatherUrlByCityName(cityName));

  Future<Weather> getWeatherByCoordinates(double latitude, double longitude) =>
      _getWeather(getWeatherUrlByCoordinates(latitude, longitude));

  Future<Weather> getWeatherByCurrentLocation() async {
    final position = await _getCurrentLocation();
    return getWeatherByCoordinates(position.latitude, position.longitude);
  }

  Future<Weather> _getWeather(String searchUrl) async {
    final response = await _client.get(Uri.parse(searchUrl));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Unable to load weather data');
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied';
      }

      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } else {
      throw 'Location services are disabled';
    }
  }
}
