import 'package:flutter/material.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';

class ConnectionList extends StatelessWidget {
  final List<Connection> connections;
  final void Function(Connection) onTap;

  const ConnectionList({
    super.key,
    required this.connections,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (connections.isEmpty) {
      return const Center(child: Text('No connections. Add one!'));
    }

    return ListView.builder(
      itemCount: connections.length,
      itemBuilder: (context, index) {
        final connection = connections[index];
        return ListTile(
          leading: const Icon(Icons.computer_outlined),
          title: Text(connection.name),
          subtitle: Text(
            '${connection.username}@${connection.host}:${connection.port}',
          ),
          onTap: () => onTap(connection),
        );
      },
    );
  }
}
