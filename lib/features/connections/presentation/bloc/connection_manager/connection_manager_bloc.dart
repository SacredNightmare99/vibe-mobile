import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:equatable/equatable.dart';
import 'package:vibe/features/connections/domain/usecases/add_connection.dart';
import 'package:vibe/features/connections/domain/usecases/get_all_connections.dart';

part 'connection_manager_event.dart';
part 'connection_manager_state.dart';

class ConnectionManagerBloc extends Bloc<ConnectionManagerEvent, ConnectionManagerState> {
  final GetAllConnections _getAllConnections;
  final AddConnection _addConnection;

  ConnectionManagerBloc(
    this._getAllConnections,
    this._addConnection,
  ) : super(ConnectionManagerLoading()) {
    on<LoadConnections>(_onLoadConnections);
    on<AddConnectionEvent>(_onAddConnection);
  }

  Future<void> _onLoadConnections(
    LoadConnections event,
    Emitter<ConnectionManagerState> emit,
  ) async {
    emit(ConnectionManagerLoading());
    final list = await _getAllConnections();
    emit(ConnectionManagerLoaded(connections: list));
  }

  Future<void> _onAddConnection(
    AddConnectionEvent event,
    Emitter<ConnectionManagerState> emit,
  ) async {
    await _addConnection(event.connection);
    final updated = await _getAllConnections();
    emit(ConnectionManagerLoaded(connections: updated));
  }
}
