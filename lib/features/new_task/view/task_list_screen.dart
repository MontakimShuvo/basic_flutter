import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Obx(() {
      return TaskCardContainer(
        title: controller.taskName,
        tasks: controller.items.toList(),
        controller: controller,
        onRenameTap: onRenameTap,
      );
    });
  }
}