import 'package:dartssh2/dartssh2.dart';
import 'package:vibe/core/network/ssh_session.dart';

class SshManager {
  SSHClient? _client;

  bool get isConnected => _client != null;

  Future<void> connect({
    required String host,
    int port = 22,
    required String username,
    String? password,
    String? privateKey,
  }) async {
    if (isConnected) {
      await disconnect();
    }

    try {
      final socket = await SSHSocket.connect(host, port);

      _client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );

      await _client!.authenticated;
    } catch (e) {
      _client?.close();
      _client = null;
      rethrow;
    }
  }

  Future<void> disconnect() async {
    _client?.close();
    _client = null;
  }

  Future<SshSession> startShellSession() async {
    if (!isConnected) {
      throw Exception('Not connected. Call connect() first.');
    }

    // Start a shell with a PTY configuration
    final session = await _client!.shell(
      pty: SSHPtyConfig(
        width: 80, // Initial width, will be resized by terminal
        height: 25, // Initial height
      ),
    );

    // Return our custom wrapper class for the session
    return SshSession(session);
  }
}
