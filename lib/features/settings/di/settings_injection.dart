import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:vibe/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:vibe/features/settings/domain/entities/settings.dart';
import 'package:vibe/features/settings/domain/repositories/settings_repository.dart';
import 'package:vibe/features/settings/domain/usecases/get_settings.dart';
import 'package:vibe/features/settings/domain/usecases/save_settings.dart';
import 'package:vibe/features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> initSettingsFeature() async {
  //- Data sources
  final settingsBox = await Hive.openBox<Settings>('settings');
  sl.registerLazySingleton<Box<Settings>>(() => settingsBox);

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => SaveSettings(sl()));

  // Bloc
  sl.registerFactory(() => SettingsBloc(sl(), sl()));
}
