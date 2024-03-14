import 'package:flutter/material.dart';

// Define a function to return the theme data.
ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      primary: Colors.green,
      secondary: Colors.blue,
      background: Colors.white,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: Color.fromARGB(255, 2, 129, 7)),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
  );
}
