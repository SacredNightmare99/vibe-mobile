import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/core/di/injector.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';
import 'package:vibe/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:vibe/features/terminal/presentation/bloc/terminal_bloc.dart';
import 'package:vibe/features/vibes/presentation/bloc/vibes_bloc.dart';

class VibeApp extends StatelessWidget {
  const VibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ConnectionBloc>()),
        BlocProvider(create: (_) => sl<TerminalBloc>()),
        BlocProvider(create: (_) => sl<VibesBloc>()),
        BlocProvider(create: (_) => sl<SettingsBloc>()),
      ],
      child: MaterialApp(
        title: "Vibe",
        theme: ThemeData.dark(useMaterial3: true),
        home: const Placeholder(),
      ),
    );
  }
}
