import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(createToJson: false)
class Weather {
  @JsonKey(name: 'name')
  final String city;

  @JsonKey(name: 'sys')
  final SystemData systemData;

  @JsonKey(name: 'main')
  final MainData mainData;

  @JsonKey(name: 'weather')
  final List<WeatherData> weatherData;

  Weather({
    this.city,
    this.systemData,
    this.mainData,
    this.weatherData,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  String get countryCode => systemData?.countryCode;
  double get temperature => mainData?.temperature;
  int get humidity => mainData?.humidity;
  String get condition => weatherData?.first?.condition;
  String get iconUrl => weatherData?.first?.iconUrl;
}

@JsonSerializable(createToJson: false)
class SystemData {
  @JsonKey(name: 'country')
  final String countryCode;

  SystemData({
    this.countryCode,
  });

  factory SystemData.fromJson(Map<String, dynamic> json) =>
      _$SystemDataFromJson(json);
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
  static const String _iconBaseUrl = 'http://openweathermap.org/img/wn/';
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
