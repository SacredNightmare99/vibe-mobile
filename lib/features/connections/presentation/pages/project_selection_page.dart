import 'package:flutter/material.dart';
import 'package:vibe/features/connections/domain/entities/project.dart';
import 'package:vibe/features/terminal/presentation/pages/terminal_page.dart';

class ProjectSelectionPage extends StatelessWidget {
  final List<Project> projects;

  const ProjectSelectionPage({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Project')),
      body: projects.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No projects found in tracked.json.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const TerminalPage()),
                      );
                    },
                    child: const Text('Open Terminal in Home Directory'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  leading: const Icon(Icons.folder_outlined),
                  title: Text(project.name),
                  subtitle: Text(project.path),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => TerminalPage(projectPath: project.path),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
