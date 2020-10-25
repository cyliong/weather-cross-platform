import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/service/weather_service.dart';

class MockClient extends Mock implements Client {}

void main() {
  test('throws an exception if the API call completes with an error', () {
    final city = 'Atlantis';
    final client = MockClient();
    final weatherService = WeatherService(client);

    when(client.get(weatherService.getWeatherByCityNameUrl(city)))
        .thenAnswer((_) async => Response('Not Found', 404));

    expect(weatherService.getWeatherByCityName(city), throwsException);
  });
}
