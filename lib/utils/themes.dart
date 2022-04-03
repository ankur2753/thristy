import 'package:flutter/material.dart';
import './constants.dart';

ThemeData myTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF0E0E10),
  backgroundColor: const Color(0xFF0E0E10),
  appBarTheme:
      const AppBarTheme(centerTitle: true, backgroundColor: Colors.black),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: kLightBlue,
    secondary: kLightBlue,
    error: red,
    background: Color(0xFF0E0E10),
    surface: kNavyBlue,
    onPrimary: kWhiteBlue,
    onSecondary: kWhiteBlue,
    onError: Color.fromARGB(255, 240, 131, 124),
    onBackground: kWhiteBlue,
    onSurface: kWhiteBlue,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
