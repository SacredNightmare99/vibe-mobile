import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_auth/connection_auth_bloc.dart';

void showPasswordPrompt(BuildContext context, Connection connection) {
  final passwordController = TextEditingController();
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('Connect to "${connection.name}"'),
        content: TextField(
          controller: passwordController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ConnectionAuthBloc>().add(
                ConnectToSystemRequested(
                  connection: connection,
                  password: passwordController.text.trim(),
                ),
              );
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Connect'),
          ),
        ],
      );
    },
  );
}
