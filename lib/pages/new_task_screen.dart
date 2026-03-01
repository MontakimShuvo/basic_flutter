import 'package:flutter/material.dart';
import '../controllers/new_task_controller.dart';

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
                  return ListTile(
                    title: Text(controller.items[index]),
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
