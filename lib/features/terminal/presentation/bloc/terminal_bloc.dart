import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/core/network/ssh_session.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final SshManager _sshManager;
  SshSession? _session;
  StreamSubscription? _outputSubscription;

  TerminalBloc(this._sshManager) : super(TerminalIdle()) {
    on<StartSession>(_onStartSession);
    on<SendCommand>(_onSendCommand);
    on<TerminalResized>(_onTerminalResized);
    on<_NewTerminalOutput>(_onNewTerminalOutput);
  }

  Future<void> _onStartSession(
    StartSession event,
    Emitter<TerminalState> emit,
  ) async {
    if (_sshManager.isConnected) {
      try {
        _session = await _sshManager.startShellSession();

        _outputSubscription?.cancel();
        _outputSubscription = _session!.outputStream.listen((output) {
          add(_NewTerminalOutput(output));
        });

        _session!.write("vibe watch &\n");
        _session!.write("gemini\n");
      } catch (e) {
        emit(TerminalOutputUpdated("Error starting shell: ${e.toString()}\n"));
      }
    } else {
      emit(TerminalOutputUpdated("Not Connected.\n"));
    }
  }

  void _onNewTerminalOutput(
    _NewTerminalOutput event,
    Emitter<TerminalState> emit,
  ) {
    emit(TerminalOutputUpdated(event.output));
  }

  void _onTerminalResized(TerminalResized event, Emitter<TerminalState> emit) {
    _session?.resize(event.width, event.height);
  }

  void _onSendCommand(SendCommand event, Emitter<TerminalState> emit) {
    _session?.write(event.command);
  }

  @override
  Future<void> close() {
    _outputSubscription?.cancel();
    _session?.close();
    return super.close();
  }
}
