import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/terminal/presentation/bloc/terminal_bloc.dart';
import 'package:xterm/xterm.dart' hide TerminalState;

class TerminalPage extends StatefulWidget {
  const TerminalPage({super.key});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  late final Terminal terminal;

  @override
  void initState() {
    super.initState();
    terminal = Terminal(platform: TerminalTargetPlatform.linux);
    context.read<TerminalBloc>().add(StartSession());
    terminal.onOutput = (output) {
      context.read<TerminalBloc>().add(SendCommandEvent(output));
    };
    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      context.read<TerminalBloc>().add(TerminalResized(width, height));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terminal')),
      body: SafeArea(
        child: BlocListener<TerminalBloc, TerminalState>(
          listener: (context, state) {
            if (state is TerminalOutputUpdated) {
              terminal.write(state.output);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TerminalView(
              terminal,
              autofocus: true,
              autoResize: true,
              textStyle: TerminalStyle(fontSize: 9),
            ),
          ),
        ),
      ),
    );
  }
}
