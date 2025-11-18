import 'package:dartz/dartz.dart';
import 'package:vibe/core/error/failure.dart';
import '../repositories/connection_repository.dart';
import '../entities/project.dart';

class GetVibeConfig {
  final ConnectionRepository repository;
  GetVibeConfig(this.repository);

  Future<Either<Failure, List<Project>>> call() => repository.getVibeConfig();
}
