import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';
import 'package:vibe/features/connections/presentation/widgets/add_connection_dialog.dart';
import 'package:vibe/features/connections/presentation/widgets/connection_list.dart';
import 'package:vibe/features/connections/presentation/widgets/loading_overlay.dart';
import 'package:vibe/features/connections/presentation/widgets/password_prompt_dialog.dart';
import 'package:vibe/features/terminal/presentation/pages/terminal_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectionBloc>().add(LoadConnections());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vibe Connections"), centerTitle: true),
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
        buildWhen: (prev, curr) =>
            curr is ConnectionListLoaded || curr is ConnectionListLoading,
        builder: (context, state) {
          if (state is ConnectionListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ConnectionListLoaded) {
            return ConnectionList(
              connections: state.connections,
              onTap: (connection) => showPasswordPrompt(context, connection),
            );
          }
          return const Center(child: Text('Loading...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddConnectionDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomSheet: const LoadingOverlay(),
    );
  }
}
