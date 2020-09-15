class Weather {
  static const String _iconBaseUrl = 'http://openweathermap.org/img/wn/';
  static const String _iconFileExtension = '@2x.png';

  final String city;
  final String countryCode;
  final double temperature;
  final int humidity;
  final String condition;
  final String iconUrl;

  Weather({
    this.city,
    this.countryCode,
    this.temperature,
    this.humidity,
    this.condition,
    this.iconUrl,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        city: json['name'],
        countryCode: json['sys']['country'],
        temperature: json['main']['temp'],
        humidity: json['main']['humidity'],
        condition: json['weather'][0]['main'],
        iconUrl: _iconBaseUrl + json['weather'][0]['icon'] + _iconFileExtension,
      );
}
