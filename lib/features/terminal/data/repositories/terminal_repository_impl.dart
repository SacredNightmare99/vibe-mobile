import 'dart:async';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/core/network/ssh_session.dart';
import 'package:vibe/features/terminal/domain/entities/terminal_output.dart';
import 'package:vibe/features/terminal/domain/repositories/terminal_repository.dart';

class TerminalRepositoryImpl implements TerminalRepository {
  final SshManager sshManager;
  SshSession? _session;
  final _controller = StreamController<TerminalOutput>.broadcast();

  TerminalRepositoryImpl(this.sshManager);

  @override
  Stream<TerminalOutput> get outputStream => _controller.stream;

  @override
  Future<void> startSession({String? projectPath}) async {
    if (!sshManager.isConnected) {
      throw Exception("SSH not connected");
    }

    _session = await sshManager.startShellSession();
    _session!.outputStream.listen((data) {
      _controller.add(TerminalOutput(data));
    });

    // send startup commands
    if (projectPath != null) {
      _session!.write("cd $projectPath\n");
    }
    // _session!.write("vibe watch &\n");
    // _session!.write("gemini\n");
  }

  @override
  Future<void> sendCommand(String command) async {
    _session?.write(command);
  }

  @override
  Future<void> resize(int width, int height) async {
    _session?.resize(width, height);
  }

  @override
  Future<void> closeSession() async {
    _session?.close();
    await _controller.close();
  }
}
