import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/core/di/injector.dart';
import 'package:vibe/core/theme/app_theme.dart';
import 'package:vibe/features/connections/presentation/bloc/connection_bloc.dart';
import 'package:vibe/features/connections/presentation/pages/connection_page.dart';
import 'package:vibe/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:vibe/features/terminal/presentation/bloc/terminal_bloc.dart';

class VibeApp extends StatelessWidget {
  const VibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SettingsBloc>()..add(LoadSettings())),
        BlocProvider(create: (_) => sl<ConnectionBloc>()),
        BlocProvider(create: (_) => sl<TerminalBloc>()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final themeMode = state is SettingsLoaded
              ? state.settings.themeMode
              : ThemeMode.dark;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Vibe",
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const ConnectionPage(),
          );
        },
      ),
    );
  }
}
