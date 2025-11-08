part of 'connection_bloc.dart';

abstract class ConnectionState extends Equatable {
  const ConnectionState();

  @override
  List<Object> get props => [];
}

class ConnectionInitial extends ConnectionState {}

class ConnectionLoading extends ConnectionState {}

class ConnectionSuccess extends ConnectionState {}

class ConnectionFailure extends ConnectionState {
  final String message;

  const ConnectionFailure(this.message);

  @override
  List<Object> get props => [message];
}

