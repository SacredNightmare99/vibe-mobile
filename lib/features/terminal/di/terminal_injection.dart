import 'package:get_it/get_it.dart';
import 'package:vibe/features/terminal/data/repositories/terminal_repository_impl.dart';
import 'package:vibe/features/terminal/domain/repositories/terminal_repository.dart';
import 'package:vibe/features/terminal/domain/usecases/listen_terminal_output.dart';
import 'package:vibe/features/terminal/domain/usecases/resize_terminal.dart';
import 'package:vibe/features/terminal/domain/usecases/send_command.dart';
import 'package:vibe/features/terminal/domain/usecases/start_terminal_session.dart';
import 'package:vibe/features/terminal/presentation/bloc/terminal_bloc.dart';

final sl = GetIt.instance;

Future<void> initTerminalFeature() async {
  // Repository
  sl.registerLazySingleton<TerminalRepository>(
    () => TerminalRepositoryImpl(sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => StartTerminalSession(sl()));
  sl.registerLazySingleton(() => SendCommand(sl()));
  sl.registerLazySingleton(() => ResizeTerminal(sl()));
  sl.registerLazySingleton(() => ListenTerminalOutput(sl()));

  // Bloc
  sl.registerFactory(() => TerminalBloc(sl(), sl(), sl(), sl()));
}
