import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './constants.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeData myDarkTheme = ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: true),
    textTheme: GoogleFonts.muliTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: kBlue,
      onPrimary: kWhiteBlue,
      secondary: kLightBlue,
      onSecondary: kWhiteBlue,
      error: red,
      onError: Color.fromARGB(255, 235, 102, 93),
      background: kDarkGrey,
      onBackground: kWhiteBlue,
      surface: kBlue,
      onSurface: Colors.white,
      tertiary: kPrussianBlue,
    ),
  );

  ThemeData myThemeLight = ThemeData.from(
    textTheme: GoogleFonts.robotoTextTheme(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: kBlue,
    ),
  );

  static bool _isDarkMode = false;

  set setDark(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  bool get isDarkTheme => _isDarkMode;
  ThemeData get currentTheme => _isDarkMode ? myDarkTheme : myThemeLight;
}
