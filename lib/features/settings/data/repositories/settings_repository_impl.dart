import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibe/features/settings/domain/entities/settings.dart';
import 'package:vibe/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Box<Settings> settingsBox;

  SettingsRepositoryImpl(this.settingsBox);

  @override
  Future<Settings> getSettings() async {
    // There should only ever be one settings object, stored at a known key.
    final settings = settingsBox.get('settings');
    if (settings == null) {
      // If no settings exist, return default settings.
      return const Settings(themeMode: ThemeMode.dark);
    }
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await settingsBox.put('settings', settings);
  }
}
