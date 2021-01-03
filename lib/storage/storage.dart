import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/weather.dart';

class Storage {
  static final _instance = Storage._();
  factory Storage() => _instance;
  Storage._();

  static const String _latitudePreferencesKey = 'lat';
  static const String _longitudePreferencesKey = 'lon';

  final _prefsFuture = SharedPreferences.getInstance();

  Future<Coordinates> getSavedCoordinates() async {
    final prefs = await _prefsFuture;
    return Coordinates(
      latitude: prefs.getDouble(_latitudePreferencesKey),
      longitude: prefs.getDouble(_longitudePreferencesKey),
    );
  }

  void saveCoordinates(Coordinates coordinates) async {
    final prefs = await _prefsFuture;
    prefs.setDouble(_latitudePreferencesKey, coordinates.latitude);
    prefs.setDouble(_longitudePreferencesKey, coordinates.longitude);
  }
}
