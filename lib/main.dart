import 'package:flutter/material.dart';
import 'package:vibe/app.dart';
import 'package:vibe/core/di/injector.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await sl.init();

  runApp(VibeApp());
}
