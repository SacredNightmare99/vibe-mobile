import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String name;
  final String path;

  const Project({required this.name, required this.path});

  @override
  List<Object?> get props => [name, path];
}
