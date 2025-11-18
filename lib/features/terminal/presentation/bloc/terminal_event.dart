part of 'terminal_bloc.dart';

abstract class TerminalEvent {}

class SendCommandEvent extends TerminalEvent {
  final String command;
  SendCommandEvent(this.command);
}

class StartSession extends TerminalEvent {
  final String? projectPath;
  StartSession({this.projectPath});
}

class TerminalResized extends TerminalEvent {
  final int width;
  final int height;
  TerminalResized(this.width, this.height);
}

class _NewOutputEvent extends TerminalEvent {
  final String output;
  _NewOutputEvent(this.output);
}
