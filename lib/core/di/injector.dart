import 'package:get_it/get_it.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';
import 'package:vibe/features/terminal/presentation/bloc/terminal_bloc.dart';
import 'package:vibe/features/vibes/presentation/bloc/vibes_bloc.dart';
import 'package:vibe/features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => ConnectionBloc());
  sl.registerFactory(() => TerminalBloc());
  sl.registerFactory(() => VibesBloc());
  sl.registerFactory(() => SettingsBloc());
}
