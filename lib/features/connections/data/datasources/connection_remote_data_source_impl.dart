import 'dart:convert';

import 'package:vibe/core/config/app_config.dart';
import 'package:vibe/core/error/exception.dart';
import 'package:vibe/core/network/ssh_manager.dart';
import 'package:vibe/features/connections/data/datasources/connection_remote_data_source.dart';
import 'package:vibe/features/connections/data/models/project_model.dart';
import 'package:vibe/core/config/constants.dart';

class ConnectionRemoteDataSourceImpl implements ConnectionRemoteDataSource {
  final SshManager sshManager;
  final AppConfig appConfig;

  ConnectionRemoteDataSourceImpl({
    required this.sshManager,
    required this.appConfig,
  });

  @override
  Future<List<ProjectModel>> getVibeConfigProjects(String username) async {
    try {
      final configFilePath = AppConfig.forUser(username).vibeConfigFilePath;
      final configContent = await sshManager.readFile(configFilePath);

      if (configContent.isEmpty) {
        throw const SshException(message: Constants.ERROR_VIBE_CONFIG_EMPTY);
      }

      final Map<String, dynamic> data = json.decode(configContent);
      final List<dynamic> projectsJson = data['projects'] ?? [];
      return projectsJson
          .map((p) => ProjectModel.fromJson(p as Map<String, dynamic>))
          .toList();
    } on SshException {
      rethrow;
    } catch (e) {
      throw SshException(
        message: '${Constants.ERROR_FAILED_TO_PARSE_CONFIG}: ${e.toString()}',
      );
    }
  }
}
