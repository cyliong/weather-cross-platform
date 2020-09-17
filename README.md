# weather-cross-platform
This is a simple cross-platform weather app written in Dart
using the Flutter framework, for both Android and iOS platforms.

It showcases various Flutter programming techniques, including:
- Asynchronous network requests using the `http` package
- Convert JSON response into a model object
- Display images from the internet using `Image.network()`
- Display data using `FutureBuilder` widget

## Features
- Search by city name
- Display the city's weather condition

## Requirements
- Flutter 1.20.4 or higher
- Dart 2.9.0 or higher

## Setup
1. Get your API key from [OpenWeatherMap](https://openweathermap.org/api).
2. Replace the `_apiKey` constant in `weather_service.dart` with your API key.
