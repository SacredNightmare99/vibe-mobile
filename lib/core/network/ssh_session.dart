import 'dart:async';
import 'dart:convert';
import 'package:dartssh2/dartssh2.dart' as dartssh2;

class SshSession {
  final dartssh2.SSHSession _session;
  final StreamController<String> _outputController =
      StreamController<String>.broadcast();

  Stream<String> get outputStream => _outputController.stream;

  SshSession(this._session) {
    _session.stdout.map(utf8.decode).listen((data) {
      _outputController.add(data);
    });

    _session.stderr.map(utf8.decode).listen((data) {
      _outputController.add(data);
    });
  }

  void write(String command) {
    _session.stdin.add(utf8.encode(command));
  }

  void resize(int width, int height) {
    _session.resizeTerminal(width, height);
  }

  void close() {
    _session.close();
    _outputController.close();
  }
}
