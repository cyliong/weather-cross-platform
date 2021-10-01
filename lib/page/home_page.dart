import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/service/weather_service.dart';
import 'package:weather/storage/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Icon _searchIcon = Icon(Icons.search);
  static const Icon _cancelIcon = Icon(Icons.cancel);

  final _client = Client();

  late final WeatherService _weatherService;
  late Icon _activeIcon;
  late Widget _titleBar;

  Future<Weather?>? _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService(_client);
    _setAppBar();
    _loadWeatherBySavedCoordinates();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleBar,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: _activeIcon,
              onPressed: () {
                setState(() {
                  if (_activeIcon.icon == Icons.search) {
                    _activeIcon = _cancelIcon;
                    _titleBar = _SearchBar(
                      onSearched: (text) {
                        if (text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please enter a city'),
                          ));
                        } else {
                          try {
                            _weatherFuture =
                                _weatherService.getWeatherByCityName(text);
                            _saveCoordinates();
                            setState(() {
                              _setAppBar();
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('$e'),
                            ));
                          }
                        }
                      },
                    );
                  } else {
                    _setAppBar();
                  }
                });
              },
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Center(
              child: FutureBuilder<Weather?>(
                  future: _weatherFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      String errorMessage;
                      if (snapshot.error is HttpException) {
                        errorMessage =
                            (snapshot.error as HttpException).message;
                      } else {
                        errorMessage = snapshot.error.toString();
                      }
                      return Text(errorMessage);
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasData) {
                        return _buildWeatherView(snapshot.data!);
                      } else {
                        return _buildEmptyView();
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildEmptyView() {
    return Column(
      children: [
        Icon(
          Icons.cloud_off,
          size: 120,
          color: Colors.grey,
        ),
        Text(
          'No weather data',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _weatherFuture = _weatherService.getWeatherByCurrentLocation();
              _saveCoordinates();
            });
          },
          icon: const Icon(
            Icons.my_location,
          ),
          label: const Text(
            'Use current location',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'or',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'press the Search button to begin.',
          style: TextStyle(
            fontSize: 20,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }

  Column _buildWeatherView(Weather weather) {
    return Column(
      children: [
        Text(
          '${weather.city}, ${weather.countryCode}',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        Text(
          '${weather.temperature.toStringAsFixed(0)}°C',
          style: TextStyle(
            fontSize: 80,
            color: Colors.lightBlue,
          ),
        ),
        Image.network(
          weather.iconUrl,
        ),
        Text('${weather.condition}'),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Humidity: ${weather.humidity}%',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  void _setAppBar() {
    _activeIcon = _searchIcon;
    _titleBar = Text(widget.title);
  }

  void _loadWeatherBySavedCoordinates() async {
    final coordinates = await Storage().getSavedCoordinates();
    setState(() {
      if (coordinates == null) {
        _weatherFuture = Future<Weather?>.value(null);
      } else {
        _weatherFuture = _weatherService.getWeatherByCoordinates(
            coordinates.latitude, coordinates.longitude);
      }
    });
  }

  void _saveCoordinates() async {
    final weather = await _weatherFuture;
    if (weather != null) {
      Storage().saveCoordinates(Coordinates(
        latitude: weather.coordinates.latitude,
        longitude: weather.coordinates.longitude,
      ));
    }
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
    required this.onSearched,
  }) : super(key: key);

  final ValueChanged<String> onSearched;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Colors.lightBlueAccent,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search a city',
      ),
      textInputAction: TextInputAction.search,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      onSubmitted: onSearched,
    );
  }
}
