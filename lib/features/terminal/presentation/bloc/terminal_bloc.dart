import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/terminal/domain/usecases/listen_terminal_output.dart';
import 'package:vibe/features/terminal/domain/usecases/resize_terminal.dart';
import 'package:vibe/features/terminal/domain/usecases/send_command.dart';
import 'package:vibe/features/terminal/domain/usecases/start_terminal_session.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final StartTerminalSession _startSession;
  final SendCommand _sendCommand;
  final ResizeTerminal _resizeTerminal;
  final ListenTerminalOutput _listenOutput;

  StreamSubscription? _outputSub;

  TerminalBloc(
    this._startSession,
    this._sendCommand,
    this._resizeTerminal,
    this._listenOutput,
  ) : super(TerminalIdle()) {
    on<StartSession>(_onStartSession);
    on<SendCommandEvent>(_onSendCommand);
    on<TerminalResized>(_onTerminalResized);
    on<_NewOutputEvent>(_onNewOutput);
  }

  Future<void> _onStartSession(
    StartSession event,
    Emitter<TerminalState> emit,
  ) async {
    try {
      await _startSession();
      _outputSub = _listenOutput().listen((output) {
        add(_NewOutputEvent(output.data));
      });
    } catch (e) {
      emit(TerminalOutputUpdated("Error: ${e.toString()}\n"));
    }
  }

  Future<void> _onSendCommand(
    SendCommandEvent event,
    Emitter<TerminalState> emit,
  ) async {
    await _sendCommand(event.command);
  }

  Future<void> _onTerminalResized(
    TerminalResized event,
    Emitter<TerminalState> emit,
  ) async {
    await _resizeTerminal(event.width, event.height);
  }

  void _onNewOutput(_NewOutputEvent event, Emitter<TerminalState> emit) {
    emit(TerminalOutputUpdated(event.output));
  }

  @override
  Future<void> close() async {
    await _outputSub?.cancel();
    return super.close();
  }
}
