import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe/app.dart';
import 'package:vibe/core/di/injector.dart' as sl;
import 'package:vibe/features/connections/data/models/connection_model.dart';
import 'package:vibe/features/settings/domain/entities/app_theme_mode.dart';
import 'package:vibe/features/settings/domain/entities/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConnectionModelAdapter());
  Hive.registerAdapter(AppThemeModeAdapter());
  Hive.registerAdapter(SettingsAdapter());

  await sl.init();

  runApp(const VibeApp());
}
