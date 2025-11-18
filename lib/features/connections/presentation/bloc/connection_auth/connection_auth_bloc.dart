import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:equatable/equatable.dart';
import 'package:vibe/features/connections/domain/entities/project.dart';
import 'package:vibe/features/connections/domain/usecases/connect_to_system.dart';
import 'package:vibe/features/connections/domain/usecases/disconnect_from_system.dart';
import 'package:vibe/features/connections/domain/usecases/get_vibe_config.dart';

part 'connection_auth_event.dart';
part 'connection_auth_state.dart';

class ConnectionAuthBloc extends Bloc<ConnectionAuthEvent, ConnectionAuthState> {
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
    final success = await _connectToSystem(
      event.connection,
      password: event.password,
    );

    if (success) {
      String? configContent;
      try {
        configContent = await _getVibeConfig();
      } catch (e) {
        await _disconnectFromSystem();
        emit(
          ConnectionAuthFailure(
            'Failed to read Vibe config: ${e.toString()}. Disconnecting...',
          ),
        );
        return;
      }

      if (configContent == null) {
        await _disconnectFromSystem();
        emit(
          ConnectionAuthFailure(
            '`tracked.json` not found in Vibe config. Disconnecting...',
          ),
        );
      } else {
        try {
          final Map<String, dynamic> data = json.decode(configContent);
          final List<dynamic> projectsJson = data['projects'] ?? [];
          final projects = projectsJson
              .map((p) => Project.fromJson(p as Map<String, dynamic>))
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
    } else {
      emit(ConnectionAuthFailure('Connection Failed'));
    }
  }

  Future<void> _onDisconnectFromSystemRequested(
    DisconnectFromSystemRequested event,
    Emitter<ConnectionAuthState> emit,
  ) async {
    await _disconnectFromSystem();
    emit(ConnectionAuthInitial());
  }
}
