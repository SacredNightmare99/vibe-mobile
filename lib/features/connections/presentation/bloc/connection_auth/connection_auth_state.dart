part of 'connection_auth_bloc.dart';

abstract class ConnectionAuthState extends Equatable {
  const ConnectionAuthState();

  @override
  List<Object> get props => [];
}

class ConnectionAuthInitial extends ConnectionAuthState {}

class ConnectionAuthLoading extends ConnectionAuthState {}

class ConnectionAuthSuccess extends ConnectionAuthState {}

class ConnectionAuthFailure extends ConnectionAuthState {
  final String message;

  const ConnectionAuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ProjectSelection extends ConnectionAuthState {
  final List<Project> projects;

  const ProjectSelection({required this.projects});

  @override
  List<Object> get props => [projects];
}

class ConnectionPasswordPromptVisible extends ConnectionAuthState {
  final Connection connection;

  const ConnectionPasswordPromptVisible({required this.connection});

  @override
  List<Object> get props => [connection];
}
