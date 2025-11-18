import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe/features/terminal/presentation/bloc/terminal_bloc.dart';
import 'package:xterm/xterm.dart' hide TerminalState;

class TerminalPage extends StatefulWidget {
  final String? projectPath;
  const TerminalPage({super.key, this.projectPath});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  late final Terminal terminal;

  @override
  void initState() {
    super.initState();
    terminal = Terminal();
    context.read<TerminalBloc>().add(
      StartSession(projectPath: widget.projectPath),
    );
    terminal.onOutput = (output) {
      context.read<TerminalBloc>().add(SendCommandEvent(output));
    };
    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      context.read<TerminalBloc>().add(TerminalResized(width, height));
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Terminal')),
        body: BlocListener<TerminalBloc, TerminalState>(
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
              textStyle: TerminalStyle(fontSize: 13.5, height: 1.15),
            ),
          ),
        ),
      ),
    );
  }
}
