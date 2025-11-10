import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  // Color Palette
  static const Color _primaryOrange = Color(0xFFF2B148);
  static const Color _lightBg = Color(0xFFECF8FD);
  static const Color _secondaryGreyBlue = Color(0xFFAFCBD5);
  static const Color _darkBg = Color(0xFF272838);
  static const Color _tertiaryMutedRed = Color(0xFF815355);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryOrange,
      brightness: Brightness.light,
      primary: _primaryOrange,
      secondary: _secondaryGreyBlue,
      tertiary: _tertiaryMutedRed,
      surface: _lightBg,
      onPrimary: _darkBg, // Text on primary color
      onSecondary: _darkBg,
      onSurface: _darkBg, // Text on cards, etc.
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryOrange,
      foregroundColor: _darkBg,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryOrange,
      foregroundColor: _darkBg,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primaryOrange,
        foregroundColor: _darkBg,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        fontWeight: FontWeight.bold,
        color: _darkBg,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: _darkBg,
      ),
      bodyLarge: TextStyle(fontSize: 16.0, height: 1.5, color: _darkBg),
      bodyMedium: TextStyle(fontSize: 14.0, height: 1.4, color: _darkBg),
      labelSmall: TextStyle(fontSize: 11.0, color: Colors.black54),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryOrange,
      brightness: Brightness.dark,
      primary: _primaryOrange,
      secondary: _secondaryGreyBlue,
      tertiary: _tertiaryMutedRed,
      surface: _darkBg,
      onPrimary: _darkBg, // Text on primary color
      onSecondary: _darkBg,
      onSurface: _lightBg, // Text on cards, etc.
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkBg,
      foregroundColor: _primaryOrange,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryOrange,
      foregroundColor: _darkBg,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primaryOrange,
        foregroundColor: _darkBg,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        fontWeight: FontWeight.bold,
        color: _lightBg,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: _lightBg,
      ),
      bodyLarge: TextStyle(fontSize: 16.0, height: 1.5, color: _lightBg),
      bodyMedium: TextStyle(fontSize: 14.0, height: 1.4, color: _lightBg),
      labelSmall: TextStyle(fontSize: 11.0, color: Colors.white70),
    ),
  );
}
