import 'package:flutter/material.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/service/weather_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Icon _searchIcon = Icon(Icons.search);
  static const Icon _cancelIcon = Icon(Icons.cancel);

  final WeatherService _weatherService = WeatherService();

  Icon _activeIcon;
  Widget _titleBar;

  Weather _weather;

  @override
  void initState() {
    super.initState();
    _setAppBar();
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
                      onSearched: (text) async {
                        if (text?.trim()?.isEmpty ?? true) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Please enter a city'),
                          ));
                        } else {
                          _weather = await _weatherService.getWeather(text);
                          setState(() {
                            _weather = _weather;
                            _setAppBar();
                          });
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
              child: _weather == null
                  ? Column(
                      children: [
                        Icon(
                          Icons.cloud_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        Text(
                          'No weather data',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                          ),
                          child: Text(
                            'Press the Search button to begin.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          '${_weather.city}, ${_weather.countryCode}',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                        Text(
                          '${_weather.temperature.toStringAsFixed(0)}°C',
                          style: TextStyle(
                            fontSize: 80,
                            color: Colors.lightBlue,
                          ),
                        ),
                        Image.network(
                          _weather.iconUrl,
                        ),
                        Text('${_weather.condition}'),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Humidity: ${_weather.humidity}%',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _setAppBar() {
    _activeIcon = _searchIcon;
    _titleBar = Text(widget.title);
  }
}

class _SearchBar extends StatelessWidget {
  _SearchBar({this.onSearched});

  final ValueChanged<String> onSearched;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Colors.lightBlueAccent,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search a city',
      ),
      textInputAction: TextInputAction.search,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      onSubmitted: onSearched,
    );
  }
}
