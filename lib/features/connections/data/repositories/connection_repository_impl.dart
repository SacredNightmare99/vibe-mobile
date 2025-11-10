import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:vibe/features/connections/domain/repositories/connection_repository.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final SshManager sshManager;

  // For now, simulate persistence
  final List<Connection> _savedConnections = [
    const Connection(
      id: '1',
      name: 'Localhost (Emulator)',
      host: '10.0.2.2',
      port: 22,
      username: 'sacred',
    ),
    const Connection(
      id: '2',
      name: 'Dev Server',
      host: 'dev.example.com',
      port: 22,
      username: 'dev',
    ),
  ];

  ConnectionRepositoryImpl(this.sshManager);

  @override
  Future<List<Connection>> getAllConnections() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_savedConnections);
  }

  @override
  Future<void> addConnection(Connection connection) async {
    final newConnection = connection.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _savedConnections.add(newConnection);
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
