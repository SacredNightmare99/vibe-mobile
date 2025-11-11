import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe/app.dart';
import 'package:vibe/core/di/injector.dart' as sl;
import 'package:vibe/features/connections/data/models/connection_model.dart';
import 'package:vibe/features/settings/data/models/theme_mode_adapter.dart';
import 'package:vibe/features/settings/domain/entities/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConnectionModelAdapter());
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(ThemeModeAdapter());

  await sl.init();

  runApp(const VibeApp());
}
