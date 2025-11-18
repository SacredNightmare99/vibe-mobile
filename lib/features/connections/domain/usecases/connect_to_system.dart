import 'package:dartz/dartz.dart';
import 'package:vibe/core/error/failure.dart';
import '../entities/connection.dart';
import '../repositories/connection_repository.dart';

class ConnectToSystem {
  final ConnectionRepository repository;
  ConnectToSystem(this.repository);

  Future<Either<Failure, bool>> call(
    Connection connection, {
    String? password,
  }) => repository.connect(connection, password: password);
}
