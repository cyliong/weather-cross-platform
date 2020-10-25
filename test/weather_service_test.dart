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
  test('returns a Weather if the API call completes successfully', () async {
    final city = 'Singapore';
    final client = MockClient();
    final weatherService = WeatherService(client);

    when(client.get(weatherService.getWeatherByCityNameUrl(city)))
        .thenAnswer((_) async => Response(weatherJson, 200));

    expect(await weatherService.getWeatherByCityName(city), isA<Weather>());
  });

  test('throws an exception if the API call completes with an error', () {
    final city = 'Atlantis';
    final client = MockClient();
    final weatherService = WeatherService(client);

    when(client.get(weatherService.getWeatherByCityNameUrl(city)))
        .thenAnswer((_) async => Response('Not Found', 404));

    expect(weatherService.getWeatherByCityName(city), throwsException);
  });
}