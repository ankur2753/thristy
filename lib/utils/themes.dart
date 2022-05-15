import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import './constants.dart';

ThemeData myTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF0E0E10),
  backgroundColor: const Color(0xFF0E0E10),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  cardColor: Colors.grey.shade800,
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: Color(0xFF0E0E10),
    dialBackgroundColor: kNavyBlue,
  ),
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      )),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: kLightBlue,
    secondary: kLightBlue,
    error: red,
    background: Color(0xFF0E0E10),
    surface: kPurple,
    onPrimary: kWhiteBlue,
    onSecondary: kWhiteBlue,
    onError: Color.fromARGB(255, 240, 131, 124),
    onBackground: kWhiteBlue,
    onSurface: kWhiteBlue,
    tertiary: kTert,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
