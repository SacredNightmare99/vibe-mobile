part of 'connection_manager_bloc.dart';

abstract class ConnectionManagerEvent extends Equatable {
  const ConnectionManagerEvent();

  @override
  List<Object?> get props => [];
}

class LoadConnections extends ConnectionManagerEvent {}

class AddConnectionEvent extends ConnectionManagerEvent {
  final Connection connection;
  const AddConnectionEvent(this.connection);

  @override
  List<Object?> get props => [connection];
}
