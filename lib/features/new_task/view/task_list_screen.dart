import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider.value(
      value: controller,
      child: TaskCardContainer(controller: controller, onRenameTap: onRenameTap)
    );
  }
}
