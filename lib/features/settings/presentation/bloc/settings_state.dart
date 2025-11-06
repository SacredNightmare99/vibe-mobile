part of 'settings_bloc.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsUpdated extends SettingsState {
  final bool darkMode;
  SettingsUpdated(this.darkMode);
}
