import 'package:get_it/get_it.dart';
import 'package:vibe/core/config/app_config.dart';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/features/connections/di/connections_injection.dart';
import 'package:vibe/features/settings/di/settings_injection.dart';
import 'package:vibe/features/terminal/di/terminal_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => SshManager());
  sl.registerLazySingleton(() => const AppConfig());

  // Features
  await initConnectionsFeature();
  await initTerminalFeature();
  await initSettingsFeature();
}
