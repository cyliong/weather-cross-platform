# weather-cross-platform
This is a simple cross-platform weather app written in Dart
using the Flutter framework, for both Android and iOS platforms.

It showcases various Flutter programming techniques, including:
- Asynchronous network requests using the `http` package
- Deserialize JSON response using `json_serializable`
- Display images from the internet using `Image.network()`
- Display data using `FutureBuilder` widget
- Find current location using `geolocator`
- Store key-value data using `shared_preferences`
- Singleton pattern with factory constructor
- Unit testing using `mockito`
- Sound null safety

## Features
- Search by city name
- Display the city's weather condition
- Detect the current location and display its weather condition
- Remember previously searched location

## Dependencies
- json_serializable
- geolocator
- shared_preferences

## Requirements
- Flutter 2.0.3 or higher
- Dart 2.12.0 or higher

## Setup
1. Get your API key from [OpenWeatherMap](https://openweathermap.org/api).
2. Replace the `_apiKey` constant in `weather_service.dart` with your API key.
