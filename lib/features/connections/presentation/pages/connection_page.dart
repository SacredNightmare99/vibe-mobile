import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_auth/connection_auth_bloc.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_manager/connection_manager_bloc.dart';
import 'package:vibe/features/connections/presentation/pages/project_selection_page.dart';
import 'package:vibe/features/connections/presentation/widgets/add_connection_dialog.dart';
import 'package:vibe/features/connections/presentation/widgets/connection_list.dart';
import 'package:vibe/features/connections/presentation/widgets/loading_overlay.dart';
import 'package:vibe/features/connections/presentation/widgets/password_prompt_dialog.dart';
import 'package:vibe/features/settings/presentation/pages/settings_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectionManagerBloc>().add(LoadConnections());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vibe Connections"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          ],
        ),
        body: BlocListener<ConnectionAuthBloc, ConnectionAuthState>(
          listener: (context, state) {
            if (state is ConnectionPasswordPromptVisible) {
              showPasswordPrompt(context, state.connection);
            } else if (state is ProjectSelection) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ProjectSelectionPage(projects: state.projects),
                ),
              );
            } else if (state is ConnectionAuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<ConnectionManagerBloc, ConnectionManagerState>(
            builder: (context, state) {
              if (state is ConnectionManagerLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ConnectionManagerLoaded) {
                return ConnectionList(
                  connections: state.connections,
                  onTap: (connection) => context.read<ConnectionAuthBloc>().add(
                    ShowPasswordPrompt(connection),
                  ),
                );
              }
              return const Center(child: Text('Loading...'));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showAddConnectionDialog(context),
          child: const Icon(Icons.add),
        ),
        bottomSheet: const LoadingOverlay(),
      ),
    );
  }
}
