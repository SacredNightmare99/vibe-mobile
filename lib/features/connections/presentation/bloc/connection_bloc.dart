import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:equatable/equatable.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final SshManager _sshManager;

  ConnectionBloc(this._sshManager) : super(ConnectionInitial()) {
    on<ConnectRequested>(_onConnectRequested);
    on<DisconnectRequested>(_onDisconnectRequested);
  }

  Future<void> _onConnectRequested(
    ConnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(ConnectionLoading());
    try {
      await _sshManager.connect(
        host: event.connection.host,
        port: event.connection.port,
        username: event.connection.username,
        password: event.connection.password,
      );
      emit(ConnectionSuccess());
    } catch (e) {
      emit(ConnectionFailure(e.toString()));
    }
  }

  Future<void> _onDisconnectRequested(
    DisconnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    await _sshManager.disconnect();
    emit(ConnectionInitial());
  }
}
