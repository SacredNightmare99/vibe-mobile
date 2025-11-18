import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:vibe/core/network/ssh_session.dart';

class SshManager {
  SSHClient? _client;
  String? _username;

  bool get isConnected => _client != null;
  String? get username => _username;

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

      _username = username;

      await _client!.authenticated;
    } catch (e) {
      _client?.close();
      _client = null;
      _username = null;
      rethrow;
    }
  }

  Future<void> disconnect() async {
    _client?.close();
    _client = null;
    _username = null;
  }

  Future<SshSession> startShellSession() async {
    if (!isConnected) {
      throw Exception('Not connected. Call connect() first.');
    }

    final session = await _client!.execute(
      'bash',
      pty: SSHPtyConfig(width: 80, height: 25),
    );

    return SshSession(session);
  }

  Future<String?> readFile(String path) async {
    if (!isConnected) {
      throw Exception('Not Connected.');
    }
    try {
      final sftp = await _client!.sftp();
      final file = await sftp.open(path);
      final content = await file.readBytes();
      return utf8.decode(content);
    } catch (e) {
      return null;
    }
  }
}
