import '../entities/connection.dart';
import '../repositories/connection_repository.dart';

class GetAllConnections {
  final ConnectionRepository repository;
  GetAllConnections(this.repository);

  Future<List<Connection>> call() => repository.getAllConnections();
}
