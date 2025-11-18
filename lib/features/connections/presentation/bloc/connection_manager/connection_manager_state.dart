part of 'connection_manager_bloc.dart';

abstract class ConnectionManagerState extends Equatable {
  const ConnectionManagerState();

  @override
  List<Object> get props => [];
}

class ConnectionManagerLoading extends ConnectionManagerState {}

class ConnectionManagerLoaded extends ConnectionManagerState {
  final List<Connection> connections;

  const ConnectionManagerLoaded({this.connections = const []});

  @override
  List<Object> get props => [connections];
}
