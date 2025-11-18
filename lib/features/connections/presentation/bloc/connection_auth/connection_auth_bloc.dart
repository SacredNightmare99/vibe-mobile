import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/data/models/project_model.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:equatable/equatable.dart';
import 'package:vibe/features/connections/domain/entities/project.dart';
import 'package:vibe/features/connections/domain/usecases/connect_to_system.dart';
import 'package:vibe/features/connections/domain/usecases/disconnect_from_system.dart';
import 'package:vibe/features/connections/domain/usecases/get_vibe_config.dart';
import 'package:vibe/features/connections/domain/usecases/get_connected_username.dart';

part 'connection_auth_event.dart';
part 'connection_auth_state.dart';

class ConnectionAuthBloc
    extends Bloc<ConnectionAuthEvent, ConnectionAuthState> {
  final ConnectToSystem _connectToSystem;
  final DisconnectFromSystem _disconnectFromSystem;
  final GetVibeConfig _getVibeConfig;
  final GetConnectedUsername _getConnectedUsername;

  ConnectionAuthBloc(
    this._connectToSystem,
    this._disconnectFromSystem,
    this._getVibeConfig,
    this._getConnectedUsername,
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
        final username = _getConnectedUsername();
        if (username == null) {
          await _disconnectFromSystem();
          emit(
            const ConnectionAuthFailure(
              'Failed to retrieve connected username. Disconnecting...',
            ),
          );
          return;
        }

        final configContentResult = await _getVibeConfig(username);

        await configContentResult.fold(
          (failure) async {
            await _disconnectFromSystem();
            emit(ConnectionAuthFailure(failure.message));
          },
          (configContent) async {
            if (configContent.isEmpty) {
              // Assuming empty string means not found or invalid
              await _disconnectFromSystem();
              emit(
                const ConnectionAuthFailure(
                  '`tracked.json` not found in Vibe config or is empty. Disconnecting...',
                ),
              );
            } else {
              try {
                final Map<String, dynamic> data = json.decode(configContent);
                final List<dynamic> projectsJson = data['projects'] ?? [];
                final projects = projectsJson
                    .map(
                      (p) => ProjectModel.fromJson(
                        p as Map<String, dynamic>,
                      ).toEntity(),
                    )
                    .toList();
                emit(ProjectSelection(projects: projects));
              } catch (e) {
                await _disconnectFromSystem();
                emit(
                  ConnectionAuthFailure(
                    'Failed to parse vibe config (tracked.json): ${e.toString()}. Disconnecting...',
                  ),
                );
              }
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
