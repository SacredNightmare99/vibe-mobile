import '../repositories/connection_repository.dart';

class GetVibeConfig {
  final ConnectionRepository repository;
  GetVibeConfig(this.repository);

  Future<String?> call() => repository.getVibeConfig();
}
