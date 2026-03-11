import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/app_constants.dart';
import 'package:untitled/data/model/subtask.dart';
import 'package:untitled/features/new_task/controller/new_task_controller.dart';
import 'package:untitled/features/new_task/view/widget/pending_task_widget.dart';
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
          PendingTaskWidget(title: title, controller: controller, tasks: tasks),
        ],
      ),
    );
  }
}


