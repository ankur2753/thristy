import 'package:flutter/material.dart';
import './constants.dart';

ThemeData myTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  appBarTheme:
      const AppBarTheme(centerTitle: true, backgroundColor: Colors.black),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: kNavyBlue,
    secondary: kNavyBlue,
    error: red,
    background: Colors.black,
    surface: kSand,
    onPrimary: kSand,
    onSecondary: kWhiteBlue,
    onError: Color.fromARGB(255, 240, 131, 124),
    onBackground: kWhiteBlue,
    onSurface: kWhiteBlue,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
