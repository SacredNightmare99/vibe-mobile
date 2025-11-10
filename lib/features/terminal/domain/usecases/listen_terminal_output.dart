import '../entities/terminal_output.dart';
import '../repositories/terminal_repository.dart';

class ListenTerminalOutput {
  final TerminalRepository repository;
  ListenTerminalOutput(this.repository);

  Stream<TerminalOutput> call() => repository.outputStream;
}
