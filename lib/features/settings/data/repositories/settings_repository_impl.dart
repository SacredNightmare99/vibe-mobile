import 'package:hive/hive.dart';
import 'package:vibe/features/settings/domain/entities/app_theme_mode.dart';
import 'package:vibe/features/settings/domain/entities/settings.dart';
import 'package:vibe/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Box<Settings> settingsBox;

  SettingsRepositoryImpl(this.settingsBox);

  @override
  Future<Settings> getSettings() async {
    final settings = settingsBox.get('settings');
    if (settings == null) {
      return const Settings(themeMode: AppThemeMode.dark);
    }
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await settingsBox.put('settings', settings);
  }
}
