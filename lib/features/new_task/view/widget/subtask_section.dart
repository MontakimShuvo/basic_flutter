import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../data/model/subtask.dart';
import '../../../task_details/view/widget/subtask_tile.dart';
import '../../controller/new_task_controller.dart';

class SubtaskSection extends StatelessWidget {
  const SubtaskSection({
    super.key,
    required this.controller,
    required this.task,
  });

  final NewTaskController controller;
  final Map<String, dynamic> task;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.loadSubtasks(task['id']),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}