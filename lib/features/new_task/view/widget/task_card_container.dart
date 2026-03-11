import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/app_constants.dart';
import 'package:untitled/data/database_service.dart';
import 'package:untitled/data/model/subtask.dart';
import 'package:untitled/features/new_task/controller/new_task_controller.dart';
import 'package:untitled/features/task_details/view/task_details_screen.dart';
import 'package:untitled/features/task_details/view/widget/subtask_tile.dart';

import '../../../../constants/app_colors_as.dart';
import '../../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../../../home/view/widget/sort_bottom_sheet.dart';

class TaskCardContainer extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tasks;
  final NewTaskController controller;

  const TaskCardContainer({
    super.key,
    required this.title,
    required this.tasks,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.noCardFoundBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  Center(
              child: Image.asset(
                'assets/icons/no_task_found.png',
                width: double.infinity,
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFF1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: AppConstants.valueDouble15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        CommonBottomSheet.show(
                          context: context,
                          body: SortBottomSheet(
                            selectedSort: "my_order", // Manage this state in your controller
                            onSortSelected: (value) {
                              controller.sortTasks(value);
                                // Handle the sort tasks on the base value type
                            },
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/icons/ic_sorting.png',
                        width: 20,
                        height: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  children: tasks.map((task) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(task: task)),
                        );
                        controller.loadTasks();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppConstants.valueDouble8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              task['is_completed'] == 1
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: task['is_completed'] == 1
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            const SizedBox(width: AppConstants.valueDouble12),

                            Expanded(
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
                                      color: task['is_completed'] == 1
                                          ? Colors.grey
                                          : Colors.black,

                                    ),
                                  ),

                                  Text(
                                    task['notes'] ?? '',
                                    style: TextStyle(
                                      fontSize: AppConstants.valueDouble12,
                                    ),
                                  ),
                                  if (task['due_date'] != null)
                                    Text(
                                      DateFormat('EEEE, MMM d, h:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              task['due_date'])),
                                      style: TextStyle(
                                        fontSize: AppConstants.valueDouble12,
                                      ),
                                    ),

                                  FutureBuilder<List<Map<String, dynamic>>>(
                                    future: controller.loadSubtasks(task['id']),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                        return Column(
                                          crossAxisAlignment: .start,
                                          children: snapshot.data!.map((stMap) {
                                            final int subtaskId = stMap['id'];
                                            final int isCompleted = stMap['is_completed'];
                                            return SubtaskTile(
                                              isShownArrow: false,
                                              width: 0,
                                              fontSize: AppConstants.valueDouble14,
                                              subtask: Subtask(
                                                id: subtaskId,
                                                title: stMap['title'],
                                                isCompleted: isCompleted,
                                                controller: TextEditingController(text: stMap['title']),
                                              ),
                                              onRemove: () async {
                                                await controller.deleteSubtask(subtaskId);
                                              },
                                            );
                                          }).toList(),
                                        );
                                      }
                                      return const SizedBox(height: 2);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
