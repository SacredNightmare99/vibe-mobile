import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_auth/connection_auth_bloc.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionAuthBloc, ConnectionAuthState>(
      buildWhen: (prev, curr) =>
          curr is ConnectionAuthLoading ||
          (prev is ConnectionAuthLoading && curr is! ConnectionAuthLoading),
      builder: (context, state) {
        if (state is ConnectionAuthLoading) {
          return const LinearProgressIndicator();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
