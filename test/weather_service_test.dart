import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/service/weather_service.dart';

class MockClient extends Mock implements Client {}

const weatherJson = '''
{
"coord": {"lon": 103.85, "lat": 1.29},
"weather": [{"main": "Rain", "icon": "10n"}],
"main": {"temp": 28.6, "humidity": 74},
"sys": {"country": "SG"},
"name": "Singapore"
}
''';

void main() {
  MockClient client;
  WeatherService weatherService;

  setUp(() {
    client = MockClient();
    weatherService = WeatherService(client);
  });

  group('WeatherService', () {
    test('returns weather data if the API call completes successfully',
        () async {
      final city = 'Singapore';
      when(client.get(weatherService.getWeatherByCityNameUrl(city)))
          .thenAnswer((_) async => Response(weatherJson, 200));

      final weather = await weatherService.getWeatherByCityName(city);

      expect(weather, isA<Weather>());
      expect(weather.city, 'Singapore');
      expect(weather.countryCode, 'SG');
      expect(weather.temperature, 28.6);
      expect(weather.humidity, 74);
      expect(weather.condition, 'Rain');
    });

    test('throws an exception if the API call completes with an error', () {
      final city = 'Atlantis';
      when(client.get(weatherService.getWeatherByCityNameUrl(city)))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(weatherService.getWeatherByCityName(city), throwsException);
    });
  });
}
