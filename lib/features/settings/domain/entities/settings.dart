import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends Equatable {
  @HiveField(0)
  final ThemeMode themeMode;

  const Settings({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];

  Settings copyWith({ThemeMode? themeMode}) {
    return Settings(themeMode: themeMode ?? this.themeMode);
  }
}
