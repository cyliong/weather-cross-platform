// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    city: json['name'] as String,
    systemData: json['sys'] == null
        ? null
        : SystemData.fromJson(json['sys'] as Map<String, dynamic>),
    mainData: json['main'] == null
        ? null
        : MainData.fromJson(json['main'] as Map<String, dynamic>),
    weatherData: (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : WeatherData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

SystemData _$SystemDataFromJson(Map<String, dynamic> json) {
  return SystemData(
    countryCode: json['country'] as String,
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
