import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/weather.dart';

class Storage {
  static final _instance = Storage._();
  factory Storage() => _instance;
  Storage._();

  static const String _latitudePreferencesKey = 'lat';
  static const String _longitudePreferencesKey = 'lon';

  final _prefsFuture = SharedPreferences.getInstance();

  Future<Coordinates?> getSavedCoordinates() async {
    final prefs = await _prefsFuture;

    final latitude = prefs.getDouble(_latitudePreferencesKey);
    if (latitude == null) return null;

    final longitude = prefs.getDouble(_longitudePreferencesKey);
    if (longitude == null) return null;

    return Coordinates(
      latitude: latitude,
      longitude: longitude,
    );
  }

  void saveCoordinates(Coordinates coordinates) async {
    final prefs = await _prefsFuture;
    await prefs.setDouble(_latitudePreferencesKey, coordinates.latitude);
    await prefs.setDouble(_longitudePreferencesKey, coordinates.longitude);
  }
}
