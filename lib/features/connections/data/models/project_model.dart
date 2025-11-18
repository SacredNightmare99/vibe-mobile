import 'package:equatable/equatable.dart';
import 'package:vibe/features/connections/domain/entities/project.dart';

class ProjectModel extends Equatable {
  final String name;
  final String path;

  const ProjectModel({required this.name, required this.path});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['id'] as String,
      path: json['path'] as String,
    );
  }

  Project toEntity() {
    return Project(name: name, path: path);
  }

  @override
  List<Object?> get props => [name, path];
}
