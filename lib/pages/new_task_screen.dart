import 'package:flutter/material.dart';

class NewTaskScreen extends StatelessWidget {
  final String taskName;
  const NewTaskScreen({super.key, required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.task, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            taskName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("This is a new task screen"),
        ],
      ),
    );
  }
}

