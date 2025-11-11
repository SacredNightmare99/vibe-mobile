import 'package:hive/hive.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';

part 'connection_model.g.dart';

@HiveType(typeId: 0)
class ConnectionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String host;
  @HiveField(3)
  final int port;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String? password;
  @HiveField(6)
  final String? privateKey;

  const ConnectionModel({
    required this.id,
    required this.name,
    required this.host,
    required this.port,
    required this.username,
    this.password,
    this.privateKey,
  });

  ConnectionModel copyWith({
    String? id,
    String? name,
    String? host,
    int? port,
    String? username,
    String? password,
    String? privateKey,
  }) {
    return ConnectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      host: host ?? this.host,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
      privateKey: privateKey ?? this.privateKey,
    );
  }

  factory ConnectionModel.fromEntity(Connection connection) {
    return ConnectionModel(
      id: connection.id,
      name: connection.name,
      host: connection.host,
      port: connection.port,
      username: connection.username,
      password: connection.password,
      privateKey: connection.privateKey,
    );
  }

  Connection toEntity() {
    return Connection(
      id: id,
      name: name,
      host: host,
      port: port,
      username: username,
      password: password,
      privateKey: privateKey,
    );
  }
}
