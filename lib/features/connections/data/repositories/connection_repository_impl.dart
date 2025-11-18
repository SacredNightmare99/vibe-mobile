import 'package:hive/hive.dart';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/features/connections/data/models/connection_model.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:vibe/features/connections/domain/repositories/connection_repository.dart';
import 'package:vibe/core/error/failure.dart';
import 'package:vibe/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:vibe/core/config/app_config.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final SshManager sshManager;
  final Box<ConnectionModel> connectionBox;
  final AppConfig appConfig;

  ConnectionRepositoryImpl(this.sshManager, this.connectionBox, this.appConfig);

  @override
  Future<List<Connection>> getAllConnections() async {
    return connectionBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addConnection(Connection connection) async {
    final newConnectionModel = ConnectionModel.fromEntity(
      connection,
    ).copyWith(id: DateTime.now().millisecondsSinceEpoch.toString());
    await connectionBox.put(newConnectionModel.id, newConnectionModel);
  }

  @override
  Future<Either<Failure, bool>> connect(
    Connection connection, {
    String? password,
  }) async {
    try {
      await sshManager.connect(
        host: connection.host,
        port: connection.port,
        username: connection.username,
        password: password,
      );
      return const Right(true);
    } on SshException catch (e) {
      return Left(SshFailure(message: e.message));
    } catch (e) {
      return Left(SshFailure(message: e.toString()));
    }
  }

  @override
  Future<void> disconnect() async {
    await sshManager.disconnect();
  }

  @override
  Future<Either<Failure, String>> getVibeConfig(String username) async {
    try {
      final configContent = await sshManager.readFile(
        AppConfig.forUser(username).vibeConfigFilePath,
      );
      return Right(configContent);
    } on SshException catch (e) {
      return Left(SshFailure(message: e.message));
    } catch (e) {
      return Left(SshFailure(message: e.toString()));
    }
  }

  @override
  String? getConnectedUsername() {
    return sshManager.username;
  }
}
