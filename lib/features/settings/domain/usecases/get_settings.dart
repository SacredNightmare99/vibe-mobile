import 'package:vibe/features/settings/domain/entities/settings.dart';
import 'package:vibe/features/settings/domain/repositories/settings_repository.dart';

class GetSettings {
  final SettingsRepository repository;

  GetSettings(this.repository);

  Future<Settings> call() => repository.getSettings();
}
