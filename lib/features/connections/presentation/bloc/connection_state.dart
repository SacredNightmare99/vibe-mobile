part of 'connection_bloc.dart';

abstract class ConnectionState extends Equatable {
  const ConnectionState();

  @override
  List<Object> get props => [];
}

class ConnectionListLoading extends ConnectionState {}

class ConnectionListLoaded extends ConnectionState {
  final List<Connection> connections;

  const ConnectionListLoaded({this.connections = const []});

  @override
  List<Object> get props => [connections];
}

class ConnectionLoading extends ConnectionState {}

class ConnectionSuccess extends ConnectionState {}

class ConnectionFailure extends ConnectionState {
  final String message;

  const ConnectionFailure(this.message);

  @override
  List<Object> get props => [message];
}
