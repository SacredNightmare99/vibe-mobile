import 'package:vibe/core/config/constants.dart';

class AppConfig {
  final String vibeConfigFilePath;

  const AppConfig({this.vibeConfigFilePath = Constants.VIBE_CONFIG_FILE_NAME});

  factory AppConfig.forUser(String username) {
    return AppConfig(
      vibeConfigFilePath: '/home/$username/${Constants.VIBE_CONFIG_FILE_NAME}',
    );
  }
}
