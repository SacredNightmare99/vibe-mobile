import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<UpdateTheme>(_onUpdateTheme);
  }

  void _onUpdateTheme(UpdateTheme event, Emitter<SettingsState> emit) {
    emit(SettingsUpdated(event.darkMode));
  }
}
