part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

class ConnectRequested extends ConnectionEvent {
  final Connection connection;

  const ConnectRequested(this.connection);

  @override
  List<Object> get props => [connection];
}

class DisconnectRequested extends ConnectionEvent {}
