part of 'terminal_bloc.dart';

abstract class TerminalEvent {}

class SendCommand extends TerminalEvent {
  final String command;
  SendCommand(this.command);
}
