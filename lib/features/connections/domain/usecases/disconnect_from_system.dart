import '../repositories/connection_repository.dart';

class DisconnectFromSystem {
  final ConnectionRepository repository;
  DisconnectFromSystem(this.repository);

  Future<void> call() => repository.disconnect();
}
