import 'package:flutter/material.dart';
import '../controller/new_task_controller.dart';
import 'widget/task_card_container.dart';

class TaskListScreen extends StatelessWidget {
  final NewTaskController controller;
  final VoidCallback onRenameTap;

  const TaskListScreen({
    super.key,
    required this.controller,
    required this.onRenameTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return TaskCardContainer(
          title: controller.taskName,
          tasks: controller.items,
          controller: controller,
          onRenameTap: onRenameTap,
        );
      },
    );
  }
}