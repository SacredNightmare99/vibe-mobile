part of 'terminal_bloc.dart';

abstract class TerminalState {}

class TerminalIdle extends TerminalState {}

class TerminalOutputUpdated extends TerminalState {
  final String output;
  TerminalOutputUpdated(this.output);
}
