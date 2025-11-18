import 'package:dartz/dartz.dart';
import 'package:vibe/core/error/failure.dart';
import '../entities/connection.dart';
import '../entities/project.dart';

abstract class ConnectionRepository {
  Future<List<Connection>> getAllConnections();
  Future<void> addConnection(Connection connection);
  Future<Either<Failure, bool>> connect(
    Connection connection, {
    String? password,
  });
  Future<void> disconnect();
  Future<Either<Failure, List<Project>>> getVibeConfig();
}
