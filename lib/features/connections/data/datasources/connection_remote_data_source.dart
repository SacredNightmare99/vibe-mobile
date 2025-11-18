import 'package:vibe/features/connections/data/models/project_model.dart';

abstract class ConnectionRemoteDataSource {
  Future<List<ProjectModel>> getVibeConfigProjects(String username);
}
