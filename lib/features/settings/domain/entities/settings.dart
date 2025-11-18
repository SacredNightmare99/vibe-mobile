import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:vibe/features/settings/domain/entities/app_theme_mode.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends Equatable {
  @HiveField(0)
  final AppThemeMode themeMode;

  const Settings({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];

  Settings copyWith({AppThemeMode? themeMode}) {
    return Settings(themeMode: themeMode ?? this.themeMode);
  }
}
