import '../repositories/connection_repository.dart';

class GetConnectedUsername {
  final ConnectionRepository repository;
  GetConnectedUsername(this.repository);

  String? call() => repository.getConnectedUsername();
}

