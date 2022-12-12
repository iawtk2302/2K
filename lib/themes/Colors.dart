import 'package:flutter/material.dart';

// const Color black=Colors.black;

class Themes {
  static final dark = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF181A20),
    primarySwatch: const MaterialColor(
      0xFF181A20,
      <int, Color>{
        50: Color(0xFF181A20),
        100: Color(0xFF181A20),
        200: Color(0xFF181A20),
        300: Color(0xFF181A20),
        350: Color(0xFF181A20),
        400: Color(0xFF181A20),
        500: Color(0xFF181A20),
        600: Color(0xFF181A20),
        700: Color(0xFF181A20),
        800: Color(0xFF181A20),
        850: Color(0xFF181A20),
        900: Color(0xFF181A20),
      },
    ),
    applyElevationOverlayColor: true,
    backgroundColor: const Color(0xFF35383F),
    brightness: Brightness.dark,
    primaryIconTheme: const IconThemeData(color: Color(0xFFFBFBFB)),
    textTheme: const TextTheme(
        button: TextStyle(color: Color(0xFFFBFBFB)),
        bodyText2: TextStyle(color: Color(0xFFFBFBFB)),
        bodyText1: TextStyle(color: Color(0xFFDEDFDF))),
    cardColor: const Color(0xFF1F222A),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(const Color(0xFF35383F))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF35383F)))),
  );
  static final light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[50],
      primarySwatch: const MaterialColor(
        0xFFFAFAFA,
        <int, Color>{
          50: Color(0xFFFAFAFA),
          100: Color(0xFFF5F5F5),
          200: Color(0xFFEEEEEE),
          300: Color(0xFFE0E0E0),
          350: Color(
              0xFFD6D6D6), // only for raised button while pressed in light theme
          400: Color(0xFFBDBDBD),
          500: Color(0xFF9E9E9E),
          600: Color(0xFF757575),
          700: Color(0xFF616161),
          800: Color(0xFF424242),
          850: Color(0xFF303030), // only for background color in dark theme
          900: Color(0xFF212121),
        },
      ),
      primaryIconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(
          button: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Color(0xFF9f9f9f))),
      backgroundColor: const Color(0xFFECECEC),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.black)),
              backgroundColor: MaterialStateProperty.all(Colors.black))),
      cardColor: Colors.white);
}
