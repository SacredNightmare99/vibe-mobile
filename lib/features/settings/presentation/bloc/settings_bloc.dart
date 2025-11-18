import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/settings/domain/entities/app_theme_mode.dart';
import 'package:vibe/features/settings/domain/entities/settings.dart';
import 'package:vibe/features/settings/domain/usecases/get_settings.dart';
import 'package:vibe/features/settings/domain/usecases/save_settings.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings _getSettings;
  final SaveSettings _saveSettings;

  SettingsBloc(this._getSettings, this._saveSettings)
    : super(const SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final settings = await _getSettings();
    emit(SettingsLoaded(settings: settings));
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<SettingsState> emit,
  ) async {
    final currentSettings = await _getSettings();
    final newThemeMode = currentSettings.themeMode == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    final newSettings = currentSettings.copyWith(themeMode: newThemeMode);
    await _saveSettings(newSettings);
    emit(SettingsLoaded(settings: newSettings));
  }
}
