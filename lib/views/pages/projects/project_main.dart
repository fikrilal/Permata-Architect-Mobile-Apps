import 'package:flutter/material.dart';

class ProjectMain extends StatefulWidget {
  const ProjectMain({super.key});

  @override
  State<ProjectMain> createState() => _ProjectMainState();
}

class _ProjectMainState extends State<ProjectMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
                'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
