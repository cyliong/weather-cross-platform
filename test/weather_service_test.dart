import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/service/weather_service.dart';

import 'weather_service_test.mocks.dart';

const weatherJson = '''
{
"coord": {"lon": 103.85, "lat": 1.29},
"weather": [{"main": "Rain", "icon": "10n"}],
"main": {"temp": 28.6, "humidity": 74},
"sys": {"country": "SG"},
"name": "Singapore"
}
''';

@GenerateMocks([Client])
void main() {
  final client = MockClient();
  final weatherService = WeatherService(client);

  group('Get weather by city name', () {
    test(
        'returns weather data if the API call by city name completes successfully',
        () async {
      final city = 'Singapore';
      when(client.get(Uri.parse(weatherService.getWeatherUrlByCityName(city))))
          .thenAnswer((_) async => Response(weatherJson, 200));

      final weather = await weatherService.getWeatherByCityName(city);

      expect(weather, isA<Weather>());
      expect(weather.city, 'Singapore');
      expect(weather.countryCode, 'SG');
      expect(weather.temperature, 28.6);
      expect(weather.humidity, 74);
      expect(weather.condition, 'Rain');
    });

    test(
        'throws an exception if the API call by city name completes with an error',
        () {
      final city = 'Atlantis';
      when(client.get(Uri.parse(weatherService.getWeatherUrlByCityName(city))))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(weatherService.getWeatherByCityName(city), throwsException);
    });
  });

  group('Get weather by coordinates', () {
    test(
        'returns weather data if the API call by coordinates completes successfully',
        () async {
      final latitude = 1.29, longitude = 103.85;
      when(client.get(Uri.parse(
              weatherService.getWeatherUrlByCoordinates(latitude, longitude))))
          .thenAnswer((_) async => Response(weatherJson, 200));

      final weather =
          await weatherService.getWeatherByCoordinates(latitude, longitude);

      expect(weather, isA<Weather>());
      expect(weather.city, 'Singapore');
      expect(weather.countryCode, 'SG');
      expect(weather.temperature, 28.6);
      expect(weather.humidity, 74);
      expect(weather.condition, 'Rain');
      expect(weather.coordinates.latitude, latitude);
      expect(weather.coordinates.longitude, longitude);
    });

    test(
        'throws an exception if the API call by coordinates completes with an error',
        () {
      final latitude = 0.0, longitude = 0.0;
      when(client.get(Uri.parse(
              weatherService.getWeatherUrlByCoordinates(latitude, longitude))))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(weatherService.getWeatherByCoordinates(latitude, longitude),
          throwsException);
    });
  });
}
