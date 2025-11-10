import '../repositories/terminal_repository.dart';

class SendCommand {
  final TerminalRepository repository;
  SendCommand(this.repository);

  Future<void> call(String command) => repository.sendCommand(command);
}
