import '../repositories/terminal_repository.dart';

class StartTerminalSession {
  final TerminalRepository repository;
  StartTerminalSession(this.repository);

  Future<void> call(String? projectPath) =>
      repository.startSession(projectPath: projectPath);
}
