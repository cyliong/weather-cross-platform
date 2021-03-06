import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(createToJson: false)
class Weather {
  @JsonKey(name: 'name')
  final String city;

  @JsonKey(name: 'sys', fromJson: _countryCodeFromSystemJson)
  final String countryCode;

  @JsonKey(name: 'coord')
  final Coordinates coordinates;

  @JsonKey(name: 'main')
  final MainData mainData;

  @JsonKey(name: 'weather', fromJson: _weatherDataFromWeatherJson)
  final WeatherData weatherData;

  Weather({
    this.city,
    this.countryCode,
    this.coordinates,
    this.mainData,
    this.weatherData,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  double get temperature => mainData?.temperature;
  int get humidity => mainData?.humidity;
  String get condition => weatherData?.condition;
  String get iconUrl => weatherData?.iconUrl;

  static String _countryCodeFromSystemJson(Map<String, dynamic> systemJson) =>
      systemJson['country'] as String;

  static WeatherData _weatherDataFromWeatherJson(
          List<dynamic> weatherJsonArray) =>
      weatherJsonArray == null || weatherJsonArray.isEmpty
          ? null
          : WeatherData(
              condition: weatherJsonArray.first['main'] as String,
              icon: weatherJsonArray.first['icon'] as String,
            );
}

@JsonSerializable(createToJson: false)
class Coordinates {
  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lon')
  final double longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}

@JsonSerializable(createToJson: false)
class MainData {
  @JsonKey(name: 'temp')
  final double temperature;

  final int humidity;

  MainData({
    this.temperature,
    this.humidity,
  });

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class WeatherData {
  static const String _iconBaseUrl = 'https://openweathermap.org/img/wn/';
  static const String _iconFileExtension = '@2x.png';

  @JsonKey(name: 'main')
  final String condition;

  final String icon;

  WeatherData({
    this.condition,
    this.icon,
  });

  String get iconUrl => _iconBaseUrl + icon + _iconFileExtension;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}
