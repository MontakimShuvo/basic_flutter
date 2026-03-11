import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/features/new_task/view/widget/subtask_section.dart';

import '../../../../constants/app_constants.dart';
import '../../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../../../home/view/widget/sort_bottom_sheet.dart';
import '../../../task_details/view/task_details_screen.dart';
import '../../controller/new_task_controller.dart';
import 'header_section.dart';

class PendingTaskWidget extends StatelessWidget {
  const PendingTaskWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.tasks,
  });

  final String title;
  final NewTaskController controller;
  final List<Map<String, dynamic>> tasks;

  @override
  Widget build(BuildContext context) {
    // final pendingTasks = tasks.where((task) => task['is_completed'] == 0).toList();

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
          HeaderSection(title: title, controller: controller,onSortTap: (){
            CommonBottomSheet.show(
              context: context,
              body: SortBottomSheet(
                selectedSort: "my_order",
                onSortSelected: (value) {
                  controller.sortTasks(value);
                },
              ),
            );
          },),
          const SizedBox(height: AppConstants.valueDouble12),
          Column(
            children: tasks.map((task) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.valueDouble8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.toggleTask(task['id'], task['is_completed']);
                      },
                      child: const Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: AppConstants.valueDouble12),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailsScreen(task: task),
                          ),
                        );
                        controller.loadTasks();
                      },
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task['title'] ?? '',
                              style: const TextStyle(
                                fontSize: AppConstants.valueDouble16,
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
                            SubtaskSection(controller: controller, task: task),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}




