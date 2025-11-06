part of 'connection_bloc.dart';

abstract class ConnectionState {}

class ConnectionInitial extends ConnectionState {}

class ConnectionLoading extends ConnectionState {}

class ConnectionSuccess extends ConnectionState {}

class ConnectionFailure extends ConnectionState {}
