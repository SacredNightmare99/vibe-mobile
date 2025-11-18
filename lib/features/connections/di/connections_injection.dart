import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:vibe/features/connections/data/models/connection_model.dart';
import 'package:vibe/features/connections/data/repositories/connection_repository_impl.dart';
import 'package:vibe/features/connections/domain/repositories/connection_repository.dart';
import 'package:vibe/features/connections/domain/usecases/add_connection.dart';
import 'package:vibe/features/connections/domain/usecases/connect_to_system.dart';
import 'package:vibe/features/connections/domain/usecases/disconnect_from_system.dart';
import 'package:vibe/features/connections/domain/usecases/get_all_connections.dart';
import 'package:vibe/features/connections/domain/usecases/get_vibe_config.dart';
import 'package:vibe/features/connections/domain/usecases/get_connected_username.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_auth/connection_auth_bloc.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_manager/connection_manager_bloc.dart';

final sl = GetIt.instance;

Future<void> initConnectionsFeature() async {
  //- Data sources
  final connectionBox = await Hive.openBox<ConnectionModel>('connections');
  sl.registerLazySingleton<Box<ConnectionModel>>(() => connectionBox);

  // Repository
  sl.registerLazySingleton<ConnectionRepository>(
    () => ConnectionRepositoryImpl(sl(), sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllConnections(sl()));
  sl.registerLazySingleton(() => AddConnection(sl()));
  sl.registerLazySingleton(() => ConnectToSystem(sl()));
  sl.registerLazySingleton(() => DisconnectFromSystem(sl()));
  sl.registerLazySingleton(() => GetVibeConfig(sl()));
  sl.registerLazySingleton(() => GetConnectedUsername(sl()));

  // Bloc
  sl.registerFactory(() => ConnectionManagerBloc(sl(), sl()));
  sl.registerFactory(() => ConnectionAuthBloc(sl(), sl(), sl(), sl()));
}
