import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:equatable/equatable.dart';
import 'package:vibe/features/connections/domain/usecases/add_connection.dart';
import 'package:vibe/features/connections/domain/usecases/connect_to_system.dart';
import 'package:vibe/features/connections/domain/usecases/disconnect_from_system.dart';
import 'package:vibe/features/connections/domain/usecases/get_all_connections.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final GetAllConnections _getAllConnections;
  final AddConnection _addConnection;
  final ConnectToSystem _connectToSystem;
  final DisconnectFromSystem _disconnectFromSystem;

  ConnectionBloc(
    this._getAllConnections,
    this._addConnection,
    this._connectToSystem,
    this._disconnectFromSystem,
  ) : super(ConnectionListLoading()) {
    on<LoadConnections>(_onLoadConnections);
    on<AddConnectionEvent>(_onAddConnection);
    on<ConnectRequested>(_onConnectRequested);
    on<DisconnectRequested>(_onDisconnectRequested);
  }

  Future<void> _onLoadConnections(
    LoadConnections event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(ConnectionListLoading());
    final list = await _getAllConnections();
    emit(ConnectionListLoaded(connections: list));
  }

  Future<void> _onAddConnection(
    AddConnectionEvent event,
    Emitter<ConnectionState> emit,
  ) async {
    await _addConnection(event.connection);
    final updated = await _getAllConnections();
    emit(ConnectionListLoaded(connections: updated));
  }

  Future<void> _onConnectRequested(
    ConnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(ConnectionLoading());
    final success = await _connectToSystem(
      event.connection,
      password: event.password,
    );
    emit(
      success ? ConnectionSuccess() : ConnectionFailure('Connection Failed'),
    );
  }

  Future<void> _onDisconnectRequested(
    DisconnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    await _disconnectFromSystem();
    final list = await _getAllConnections();
    emit(ConnectionListLoaded(connections: list));
  }
}
