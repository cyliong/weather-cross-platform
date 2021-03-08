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
    coordinates: Coordinates.fromJson(json['coord'] as Map<String, dynamic>),
    mainData: MainData.fromJson(json['main'] as Map<String, dynamic>),
    weatherData: Weather._weatherDataFromWeatherJson(json['weather'] as List),
  );
}

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  return Coordinates(
    latitude: (json['lat'] as num).toDouble(),
    longitude: (json['lon'] as num).toDouble(),
  );
}

MainData _$MainDataFromJson(Map<String, dynamic> json) {
  return MainData(
    temperature: (json['temp'] as num).toDouble(),
    humidity: json['humidity'] as int,
  );
}

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) {
  return WeatherData(
    condition: json['main'] as String,
    icon: json['icon'] as String,
  );
}
