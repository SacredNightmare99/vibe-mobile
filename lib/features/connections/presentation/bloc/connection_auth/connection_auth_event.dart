part of 'connection_auth_bloc.dart';

abstract class ConnectionAuthEvent extends Equatable {
  const ConnectionAuthEvent();

  @override
  List<Object?> get props => [];
}

class ConnectToSystemRequested extends ConnectionAuthEvent {
  final Connection connection;
  final String password;

  const ConnectToSystemRequested({
    required this.connection,
    required this.password,
  });

  @override
  List<Object?> get props => [connection, password];
}

class DisconnectFromSystemRequested extends ConnectionAuthEvent {}

class ShowPasswordPrompt extends ConnectionAuthEvent {
  final Connection connection;

  const ShowPasswordPrompt(this.connection);

  @override
  List<Object?> get props => [connection];
}
