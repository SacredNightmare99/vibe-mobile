import 'package:flutter_bloc/flutter_bloc.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  ConnectionBloc() : super(ConnectionInitial()) {
    on<ConnectRequested>(_onConnectRequested);
    on<DisconnectRequested>(_onDisconnectRequested);
  }

  Future<void> _onConnectRequested(
    ConnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    emit(ConnectionLoading());
    // TODO: Implement SSH connection logic
    emit(ConnectionSuccess());
  }

  Future<void> _onDisconnectRequested(
    DisconnectRequested event,
    Emitter<ConnectionState> emit,
  ) async {
    // TODO: Implement disconnect logic
    emit(ConnectionInitial());
  }
}
