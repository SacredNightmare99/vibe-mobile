import 'package:hive/hive.dart';

part 'app_theme_mode.g.dart';

@HiveType(typeId: 2)
enum AppThemeMode {
  @HiveField(0)
  dark,

  @HiveField(1)
  light,

  @HiveField(2)
  system,
}
