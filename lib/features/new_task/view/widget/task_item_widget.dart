import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/features/new_task/view/widget/subtask_section.dart';
import 'package:untitled/routes/app_routes.dart';
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
    return Container(
      margin: const EdgeInsets.all(AppConstants.valueDouble16),
      padding: const EdgeInsets.all(AppConstants.valueDouble16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFF1),
        borderRadius: BorderRadius.circular(AppConstants.valueDouble20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSection(
            title: title,
            controller: controller,
            onSortTap: onHeaderAction,
            onRenameTap: onRenameTap,
            assetIcon: headerAssetIcon,
          ),
          if (isExpanded) ...[
            // Conditional rendering
            const SizedBox(height: AppConstants.valueDouble12),
            Column(
              children: tasks.map((task) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.valueDouble8,
                  ),
                  child: Row(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.toggleTask(
                                task['id'],
                                task['is_completed'],
                              );
                            },
                            child: Icon(
                              task['is_completed'] == 1
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: task['is_completed'] == 1
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                          const SizedBox(width: AppConstants.valueDouble12),
                          GestureDetector(
                            onTap: () async {
                              await Get.toNamed(
                                AppRoutes.taskDetails,
                                arguments: task,
                              );
                              controller.loadTasks();
                            },
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task['title'] ?? '',
                                    style: TextStyle(
                                      fontSize: AppConstants.valueDouble16,
                                      decoration: task['is_completed'] == 1
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    task['notes'] ?? '',
                                    style: const TextStyle(
                                      fontSize: AppConstants.valueDouble12,
                                    ),
                                  ),
                                  if (task['due_date'] != null)
                                    Text(
                                      DateFormat('EEEE, MMM d, h:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          task['due_date'],
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: AppConstants.valueDouble12,
                                      ),
                                    ),
                                  SubtaskSection(
                                    controller: controller,
                                    task: task,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (task['is_completed'] != 1)
                        GestureDetector(
                          onTap: () {
                            controller.toggleFavourite(
                              task['id'],
                              task['is_favourite'] ?? 0,
                            );
                          },
                          child: Icon(
                            task['is_favourite'] == 1
                                ? Icons.star
                                : Icons.star_border,
                            color: task['is_favourite'] == 1
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
