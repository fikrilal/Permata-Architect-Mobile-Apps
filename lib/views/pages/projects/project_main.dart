import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';

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
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your username',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: ListColor.gray300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: ListColor.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
