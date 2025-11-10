import '../entities/connection.dart';
import '../repositories/connection_repository.dart';

class ConnectToSystem {
  final ConnectionRepository repository;
  ConnectToSystem(this.repository);

  Future<bool> call(Connection connection, {String? password}) =>
      repository.connect(connection, password: password);
}
