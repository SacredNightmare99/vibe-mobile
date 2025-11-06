part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class UpdateTheme extends SettingsEvent {
  final bool darkMode;
  UpdateTheme(this.darkMode);
}
