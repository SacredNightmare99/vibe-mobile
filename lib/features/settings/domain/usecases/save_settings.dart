import 'package:vibe/features/settings/domain/entities/settings.dart';
import 'package:vibe/features/settings/domain/repositories/settings_repository.dart';

class SaveSettings {
  final SettingsRepository repository;

  SaveSettings(this.repository);

  Future<void> call(Settings settings) => repository.saveSettings(settings);
}
