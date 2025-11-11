import 'package:hive/hive.dart';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/features/connections/data/models/connection_model.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:vibe/features/connections/domain/repositories/connection_repository.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final SshManager sshManager;
  final Box<ConnectionModel> connectionBox;

  ConnectionRepositoryImpl(this.sshManager, this.connectionBox);

  @override
  Future<List<Connection>> getAllConnections() async {
    return connectionBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addConnection(Connection connection) async {
    final newConnectionModel = ConnectionModel.fromEntity(connection).copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await connectionBox.put(newConnectionModel.id, newConnectionModel);
  }

  @override
  Future<bool> connect(Connection connection, {String? password}) async {
    try {
      await sshManager.connect(
        host: connection.host,
        port: connection.port,
        username: connection.username,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await sshManager.disconnect();
  }
}
