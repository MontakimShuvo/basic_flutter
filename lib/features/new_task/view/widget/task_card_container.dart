import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Selector;
import 'package:untitled/features/new_task/controller/new_task_controller.dart';
import 'package:untitled/features/new_task/view/widget/task_item_widget.dart';
import 'package:untitled/features/new_task/view/widget/no_task_found_widget.dart';
import '../../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../../../home/view/widget/sort_bottom_sheet.dart';

class TaskCardContainer extends StatefulWidget {
  final NewTaskController controller;
  final VoidCallback onRenameTap;

  const TaskCardContainer({
    super.key,
    required this.controller,
    required this.onRenameTap,
  });

  @override
  State<TaskCardContainer> createState() => _TaskCardContainerState();
}

class _TaskCardContainerState extends State<TaskCardContainer> {
  bool isCompletedExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Selector<NewTaskController, List<Map<String, dynamic>>>(
            selector: (_, controller) => controller.items.toList(),
            builder: (context, tasks, child) {
              final pendingTasks = tasks.where((t) => t['is_completed'] == 0).toList();

              if (pendingTasks.isEmpty) return const NoTaskFoundWidget();

              return Selector<NewTaskController, String>(
                selector: (_, controller) => controller.taskName,
                builder: (context, taskName, child) {
                  return TaskItemWidget(
                    title: taskName,
                    controller: widget.controller,
                    tasks: pendingTasks,
                    onRenameTap: widget.onRenameTap,
                    onHeaderAction: () => _showSortSheet(context),
                  );
                },
              );
            },
          ),

          Selector<NewTaskController, List<Map<String, dynamic>>>(
            selector: (_, controller) => controller.items.toList(),
            builder: (context, tasks, child) {
              final completeTasks = tasks.where((t) => t['is_completed'] == 1).toList();
              if (completeTasks.isEmpty) return const SizedBox.shrink();

              return TaskItemWidget(
                title: "Completed (${completeTasks.length})",
                controller: widget.controller,
                tasks: completeTasks,
                isExpanded: isCompletedExpanded,
                onHeaderAction: () => setState(() => isCompletedExpanded = !isCompletedExpanded),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSortSheet(BuildContext context) {
    CommonBottomSheet.show(
      context: context,
      body: SortBottomSheet(
        selectedSort: widget.controller.currentSort,
        onSortSelected: (value) {
          widget.controller.sortTasks(value);
        },
      ),
    );
  }
}
