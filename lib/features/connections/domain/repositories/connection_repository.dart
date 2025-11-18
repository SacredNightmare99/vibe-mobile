import '../entities/connection.dart';

abstract class ConnectionRepository {
  Future<List<Connection>> getAllConnections();
  Future<void> addConnection(Connection connection);
  Future<bool> connect(Connection connection, {String? password});
  Future<void> disconnect();
  Future<String?> getVibeConfig(String username);
  String? getConnectedUsername();
}
