import 'package:flutter/material.dart';
import 'package:weather/page/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  static const String _title = 'Weather';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.pink,
        ),
      ),
      home: HomePage(title: _title),
      debugShowCheckedModeBanner: false,
    );
  }
}
