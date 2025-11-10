import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, ConnectionState>(
      buildWhen: (prev, curr) =>
          curr is ConnectionLoading ||
          (prev is ConnectionLoading && curr is! ConnectionLoading),
      builder: (context, state) {
        if (state is ConnectionLoading) {
          return const LinearProgressIndicator();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
