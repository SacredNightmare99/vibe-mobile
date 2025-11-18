import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[]]);

  final List<dynamic> properties;
  abstract final String message;

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  @override
  final String message;
  const ServerFailure({required this.message});
}

class CacheFailure extends Failure {
  @override
  final String message;
  const CacheFailure({required this.message});
}

class SshFailure extends Failure {
  @override
  final String message;
  const SshFailure({required this.message});
}
