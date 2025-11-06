import 'package:flutter_bloc/flutter_bloc.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  TerminalBloc() : super(TerminalIdle()) {
    on<SendCommand>(_onSendCommand);
  }

  void _onSendCommand(SendCommand event, Emitter<TerminalState> emit) {
    // TODO: handle SSH command dispatch via dartssh2
    emit(TerminalOutputUpdated(event.command));
  }
}
