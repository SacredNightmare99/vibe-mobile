part of 'connection_bloc.dart';

abstract class ConnectionEvent {}

class ConnectRequested extends ConnectionEvent {}

class DisconnectRequested extends ConnectionEvent {}
