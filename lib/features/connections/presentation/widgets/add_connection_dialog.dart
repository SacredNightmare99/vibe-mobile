import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_manager/connection_manager_bloc.dart';

void showAddConnectionDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final hostController = TextEditingController(text: '10.0.2.2');
  final portController = TextEditingController(text: '22');
  final userController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Add New Connection'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: hostController,
                  decoration: const InputDecoration(labelText: 'Host'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: portController,
                  decoration: const InputDecoration(labelText: 'Port'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newConnection = Connection(
                  id: '',
                  name: nameController.text.trim(),
                  host: hostController.text.trim(),
                  port: int.parse(portController.text.trim()),
                  username: userController.text.trim(),
                );
                context.read<ConnectionManagerBloc>().add(
                  AddConnectionEvent(newConnection),
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
