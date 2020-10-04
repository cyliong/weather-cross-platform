// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    city: json['name'] as String,
    countryCode:
        Weather._countryCodeFromSystemJson(json['sys'] as Map<String, dynamic>),
    mainData: json['main'] == null
        ? null
        : MainData.fromJson(json['main'] as Map<String, dynamic>),
    weatherData: Weather._weatherDataFromWeatherJson(json['weather'] as List),
  );
}

MainData _$MainDataFromJson(Map<String, dynamic> json) {
  return MainData(
    temperature: (json['temp'] as num)?.toDouble(),
    humidity: json['humidity'] as int,
  );
}

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) {
  return WeatherData(
    condition: json['main'] as String,
    icon: json['icon'] as String,
  );
}
