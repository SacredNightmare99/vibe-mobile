import '../entities/terminal_output.dart';

abstract class TerminalRepository {
  Future<void> startSession();
  Future<void> sendCommand(String command);
  Future<void> resize(int width, int height);
  Stream<TerminalOutput> get outputStream;
  Future<void> closeSession();
}
