import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/domain/entities/connection.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';
import 'package:vibe/features/terminal/presentation/pages/terminal_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _formKey = GlobalKey<FormState>();

  final _hostController = TextEditingController(text: '127.0.0.1');
  final _userController = TextEditingController(text: 'user');
  final _passController = TextEditingController();

  @override
  void dispose() {
    _hostController.dispose();
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _submitConnection() {
    if (_formKey.currentState!.validate()) {
      final connection = Connection(
        id: '1',
        name: 'Test Connection',
        host: _hostController.text.trim(),
        username: _userController.text.trim(),
        password: _passController.text.trim(),
        port: 22,
      );

      context.read<ConnectionBloc>().add(ConnectRequested(connection));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Connections"),
        centerTitle: true,
      ),
      body: BlocConsumer<ConnectionBloc, ConnectionState>(
        listener: (context, state) {
          if (state is ConnectionSuccess) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const TerminalPage()));
          } else if (state is ConnectionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ConnectionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _hostController,
                    decoration: const InputDecoration(labelText: 'Host'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a host' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a username' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a password' : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitConnection,
        child: const Icon(Icons.login),
      ),
    );
  }
}
