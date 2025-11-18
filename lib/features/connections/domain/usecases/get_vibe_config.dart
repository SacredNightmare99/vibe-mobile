import 'package:dartz/dartz.dart';
import 'package:vibe/core/error/failure.dart';
import '../repositories/connection_repository.dart';

class GetVibeConfig {
  final ConnectionRepository repository;
  GetVibeConfig(this.repository);

  Future<Either<Failure, String>> call(String username) =>
      repository.getVibeConfig(username);
}
