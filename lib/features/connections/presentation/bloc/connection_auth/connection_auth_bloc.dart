import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:equatable/equatable.dart';
import 'package:vibe/features/connections/domain/entities/project.dart';
import 'package:vibe/features/connections/domain/usecases/connect_to_system.dart';
import 'package:vibe/features/connections/domain/usecases/disconnect_from_system.dart';
import 'package:vibe/features/connections/domain/usecases/get_vibe_config.dart';
import 'package:vibe/core/config/constants.dart';

part 'connection_auth_event.dart';
part 'connection_auth_state.dart';

class ConnectionAuthBloc
    extends Bloc<ConnectionAuthEvent, ConnectionAuthState> {
  final ConnectToSystem _connectToSystem;
  final DisconnectFromSystem _disconnectFromSystem;
  final GetVibeConfig _getVibeConfig;

  ConnectionAuthBloc(
    this._connectToSystem,
    this._disconnectFromSystem,
    this._getVibeConfig,
  ) : super(ConnectionAuthInitial()) {
    on<ConnectToSystemRequested>(_onConnectToSystemRequested);
    on<DisconnectFromSystemRequested>(_onDisconnectFromSystemRequested);
    on<ShowPasswordPrompt>(_onShowPasswordPrompt);
  }

  Future<void> _onShowPasswordPrompt(
    ShowPasswordPrompt event,
    Emitter<ConnectionAuthState> emit,
  ) async {
    emit(ConnectionPasswordPromptVisible(connection: event.connection));
  }

  Future<void> _onConnectToSystemRequested(
    ConnectToSystemRequested event,
    Emitter<ConnectionAuthState> emit,
  ) async {
    emit(ConnectionAuthLoading());
    final connectionResult = await _connectToSystem(
      event.connection,
      password: event.password,
    );

    await connectionResult.fold(
      (failure) async {
        emit(ConnectionAuthFailure(failure.message));
      },
      (success) async {
        final projectsResult = await _getVibeConfig();

        await projectsResult.fold(
          (failure) async {
            await _disconnectFromSystem();
            emit(ConnectionAuthFailure(failure.message));
          },
          (projects) async {
            if (projects.isEmpty) {
              await _disconnectFromSystem();
              emit(
                const ConnectionAuthFailure(Constants.ERROR_NO_PROJECTS_FOUND),
              );
            } else {
              emit(ProjectSelection(projects: projects));
            }
          },
        );
      },
    );
  }

  Future<void> _onDisconnectFromSystemRequested(
    DisconnectFromSystemRequested event,
    Emitter<ConnectionAuthState> emit,
  ) async {
    await _disconnectFromSystem();
    emit(ConnectionAuthInitial());
  }
}
