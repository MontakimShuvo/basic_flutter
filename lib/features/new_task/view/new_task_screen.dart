import 'package:flutter/material.dart';
import '../controller/new_task_controller.dart';

class NewTaskScreen extends StatelessWidget {
  final NewTaskController controller;
  const NewTaskScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final task = controller.items[index];
                  return ListTile(
                    title: Text(task['title']),
                    leading: const Icon(Icons.label),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
