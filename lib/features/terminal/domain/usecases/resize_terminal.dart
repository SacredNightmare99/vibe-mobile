import '../repositories/terminal_repository.dart';

class ResizeTerminal {
  final TerminalRepository repository;
  ResizeTerminal(this.repository);

  Future<void> call(int width, int height) => repository.resize(width, height);
}
