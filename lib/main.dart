import 'package:flutter/material.dart';
import 'package:weather_app_minimal/home_page.dart';
import 'package:weather_app_minimal/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App Minimal',
      theme: mainTheme,
      home: HomePage(),
    );
  }
}
