import 'package:flutter/material.dart';
import 'package:vibe/features/settings/domain/entities/app_theme_mode.dart';

class ThemeModeUIAdapter {
  const ThemeModeUIAdapter._();

  static ThemeMode toFlutter(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  static AppThemeMode fromFlutter(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return AppThemeMode.dark;
      case ThemeMode.light:
        return AppThemeMode.light;
      case ThemeMode.system:
        return AppThemeMode.system;
    }
  }
}
