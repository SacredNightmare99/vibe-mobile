// ignore_for_file: constant_identifier_names

class Constants {
  const Constants._();

  static const String APP_NAME = "Vibe";
  static const int DEFAULT_SSH_PORT = 22;
  static const String VIBE_CONFIG_FILE_NAME = ".vibe/tracked.json";
  static const String CONNECTIONS_BOX = "connections";
  static const String SETTINGS_BOX = "settings";

  // Error Messages
  static const String ERROR_USERNAME_NOT_AVAILABLE =
      'Failed to retrieve connected username. Disconnecting...';
  static const String ERROR_NO_PROJECTS_FOUND =
      'No projects found in tracked.json. Disconnecting...';
  static const String ERROR_FAILED_TO_PARSE_CONFIG =
      'Failed to parse Vibe config (tracked.json). Disconnecting...';
  static const String ERROR_CONNECTION_FAILED = 'Connection Failed';
  static const String ERROR_CONNECTION_NOT_ACTIVE =
      'Not connected. Call connect() first.';
  static const String ERROR_FILE_READ_FAILED = 'Failed to read file:';
  static const String ERROR_VIBE_CONFIG_EMPTY =
      'Vibe config file is empty or not found.';
}
