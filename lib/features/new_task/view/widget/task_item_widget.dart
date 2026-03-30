import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';
import '../../controller/new_task_controller.dart';
import 'header_section.dart';

class TaskItemWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tasks;
  final NewTaskController controller;
  final VoidCallback onHeaderAction;
  final VoidCallback? onRenameTap;
  final String? headerAssetIcon;
  final bool isExpanded;

  const TaskItemWidget({
    super.key,
    required this.title,
    required this.tasks,
    required this.controller,
    required this.onHeaderAction,
    this.onRenameTap,
    this.headerAssetIcon,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: HeaderSection(
            title: title,
            controller: controller,
            onSortTap: onHeaderAction,
            onRenameTap: onRenameTap,
            assetIcon: headerAssetIcon,
          ),
        ),
        if (isExpanded)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    task['is_completed'] == 1
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task['is_completed'] == 1 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => controller.toggleTask(task['id'], task['is_completed']),
                ),
                title: Text(
                  task['title'],
                  style: TextStyle(
                    decoration: task['is_completed'] == 1
                        ? TextDecoration.lineThrough
                        : null,
                    color: task['is_completed'] == 1 ? Colors.grey : Colors.black,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    task['is_favourite'] == 1 ? Icons.star : Icons.star_border,
                    color: task['is_favourite'] == 1 ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () => controller.toggleFavourite(task['id'], task['is_favourite']),
                ),
              );
            },
          ),
      ],
    );
  }
}
