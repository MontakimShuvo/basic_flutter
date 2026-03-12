import 'package:flutter/material.dart';
import 'package:untitled/features/new_task/controller/new_task_controller.dart';
import 'package:untitled/features/new_task/view/widget/task_item_widget.dart';
import '../../../../constants/app_colors_as.dart';
import '../../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../../../home/view/widget/sort_bottom_sheet.dart';

class TaskCardContainer extends StatefulWidget {
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
  State<TaskCardContainer> createState() => _TaskCardContainerState();
}

class _TaskCardContainerState extends State<TaskCardContainer> {
  bool isCompletedExpanded = false;

  @override
  Widget build(BuildContext context) {
    final pendingTasks = widget.tasks
        .where((task) => task['is_completed'] == 0)
        .toList();
    final completeTasks = widget.tasks
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
              title: widget.title,
              controller: widget.controller,
              tasks: pendingTasks,
              onHeaderAction: () {
                CommonBottomSheet.show(
                  context: context,
                  body: SortBottomSheet(
                    selectedSort: widget.controller.currentSort,
                    onSortSelected: (value) {
                      widget.controller.sortTasks(value);
                    },
                  ),
                );
              },
            ),

          if (completeTasks.isNotEmpty)
            TaskItemWidget(
              title: "Completed (${completeTasks.length})",
              controller: widget.controller,
              tasks: completeTasks,
              headerAssetIcon: isCompletedExpanded 
                  ? "assets/icons/ic_collapse.png" 
                  : "assets/icons/ic_expand.png",
              isExpanded: isCompletedExpanded,
              onHeaderAction: () {
                setState(() {
                  isCompletedExpanded = !isCompletedExpanded;
                });
              },
            ),
        ],
      ),
    );
  }
}
