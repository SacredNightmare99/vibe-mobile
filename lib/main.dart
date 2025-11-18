import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe/app.dart';
import 'package:vibe/core/di/injector.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await sl.initAdapters();

  await sl.init();

  runApp(const VibeApp());
}
