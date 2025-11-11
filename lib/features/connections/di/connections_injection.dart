import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:vibe/features/connections/data/models/connection_model.dart';
import 'package:vibe/features/connections/data/repositories/connection_repository_impl.dart';
import 'package:vibe/features/connections/domain/repositories/connection_repository.dart';
import 'package:vibe/features/connections/domain/usecases/add_connection.dart';
import 'package:vibe/features/connections/domain/usecases/connect_to_system.dart';
import 'package:vibe/features/connections/domain/usecases/disconnect_from_system.dart';
import 'package:vibe/features/connections/domain/usecases/get_all_connections.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';

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

  // Bloc
  sl.registerFactory(() => ConnectionBloc(sl(), sl(), sl(), sl()));
}
