part of 'terminal_bloc.dart';

abstract class TerminalEvent {}

class SendCommand extends TerminalEvent {
  final String command;
  SendCommand(this.command);
}

class StartSession extends TerminalEvent {}

class TerminalResized extends TerminalEvent {
  final int width;
  final int height;
  TerminalResized(this.width, this.height);
}

class _NewTerminalOutput extends TerminalEvent {
  final String output;
  _NewTerminalOutput(this.output);
}
