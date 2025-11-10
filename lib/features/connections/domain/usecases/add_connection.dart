import '../entities/connection.dart';
import '../repositories/connection_repository.dart';

class AddConnection {
  final ConnectionRepository repository;
  AddConnection(this.repository);

  Future<void> call(Connection connection) =>
      repository.addConnection(connection);
}
