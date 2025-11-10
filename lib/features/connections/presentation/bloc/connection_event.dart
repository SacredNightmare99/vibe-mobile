part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object?> get props => [];
}

class LoadConnections extends ConnectionEvent {}

class AddConnectionEvent extends ConnectionEvent {
  final Connection connection;
  const AddConnectionEvent(this.connection);

  @override
  List<Object?> get props => [connection];
}

class ConnectRequested extends ConnectionEvent {
  final Connection connection;
  final String password;

  const ConnectRequested({required this.connection, required this.password});

  @override
  List<Object?> get props => [connection, password];
}

class DisconnectRequested extends ConnectionEvent {}
