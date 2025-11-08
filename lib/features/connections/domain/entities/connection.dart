import 'package:equatable/equatable.dart';

class Connection extends Equatable {
  final String id;
  final String name;
  final String host;
  final int port;
  final String username;
  final String? password; // For password-based auth
  final String? privateKey; // For key-based auth

  const Connection({
    required this.id,
    required this.name,
    required this.host,
    this.port = 22,
    required this.username,
    this.password,
    this.privateKey,
  });

  @override
  List<Object?> get props => [id, name, host, port, username, password, privateKey];
}
