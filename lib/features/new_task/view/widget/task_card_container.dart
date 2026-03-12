import 'package:flutter/material.dart';
import 'package:untitled/features/new_task/controller/new_task_controller.dart';
import 'package:untitled/features/new_task/view/widget/task_item_widget.dart';
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
    final pendingTasks = tasks
        .where((task) => task['is_completed'] == 0)
        .toList();
    final completeTasks = tasks
        .where((task) => task['is_completed'] == 1)
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pendingTasks.isEmpty)
            Container(
              margin: const EdgeInsets.all(16),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.noCardFoundBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/no_task_found.png',
                  width: double.infinity,
                ),
              ),
            ),

          if (pendingTasks.isNotEmpty)
            TaskItemWidget(
              title: title,
              controller: controller,
              tasks: pendingTasks,
              onHeaderAction: (){
                CommonBottomSheet.show(
                  context: context,
                  body: SortBottomSheet(
                    selectedSort: controller.currentSort,
                    onSortSelected: (value) {
                      controller.sortTasks(value);
                    },
                  ),
                );
              },
            ),

          if (completeTasks.isNotEmpty)
            TaskItemWidget(
              title: "Completed (${completeTasks.length})",
              controller: controller,
              tasks: completeTasks,
              headerAssetIcon: "assets/icons/ic_expand.png",
              onHeaderAction: (){

              },
            ),
        ],
      ),
    );
  }
}
