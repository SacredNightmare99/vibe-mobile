import '../repositories/terminal_repository.dart';

class StartTerminalSession {
  final TerminalRepository repository;
  StartTerminalSession(this.repository);

  Future<void> call() => repository.startSession();
}
