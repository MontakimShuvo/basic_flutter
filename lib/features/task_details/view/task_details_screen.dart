import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constants/app_constants.dart';
import '../../../widgets/calendar_widget/task_calendar_sheet.dart';
import '../../../widgets/text_field/common_input_field.dart';
import '../../../utils/size_config.dart';
import '../controller/task_details_controller.dart';
import 'widget/subtask_tile.dart';
import 'widget/task_detail_chip.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailsScreen({super.key, required this.task});

  void _openTaskCalendar(BuildContext context, TaskDetailsController controller) async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TaskCalendarSheet(),
    );

    if (result != null) {
      controller.updateDueDate(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String title = task['title'] ?? 'No title';
    final int? createAtMillis = task['created_at'];

    final String createAtDate = createAtMillis != null
        ? DateFormat('EEE, MMM d').format(DateTime.fromMillisecondsSinceEpoch(createAtMillis))
        : '';

    return ChangeNotifierProvider(
      create: (_) => TaskDetailsController(task: task),
      child: Builder(
        builder: (context) {
          final controller = context.read<TaskDetailsController>();

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              await controller.saveChanges();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Scaffold(
              floatingActionButton: Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff5c6bc0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Mark completed",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              body: SafeArea(
                child: Container(
                  height: SizeConfig.screenHeight * AppConstants.percent80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppConstants.valueDouble24),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppConstants.valueDouble12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.maybePop(context),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.star_border),
                                SizedBox(width: AppConstants.valueDouble16),
                                Icon(Icons.more_vert),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppConstants.valueDouble20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: AppConstants.valueDouble12),
                          child: Container(
                            padding: const EdgeInsets.all(AppConstants.valueDouble20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "My Tasks",
                                      style: TextStyle(
                                        fontSize: AppConstants.valueDouble18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff5c6bc0),
                                      ),
                                    ),
                                    SizedBox(width: AppConstants.valueDouble6),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.valueDouble25),
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: AppConstants.valueDouble28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: AppConstants.valueDouble20),
                                Row(
                                  children: [
                                    const Icon(Icons.notes_outlined),
                                    const SizedBox(width: AppConstants.valueDouble12),
                                    Expanded(
                                      child: CommonInputField(
                                        controller: controller.notesController,
                                        hintText: "Add description",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.valueDouble20),
                                GestureDetector(
                                  onTap: () => _openTaskCalendar(context, controller),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.adjust),
                                      const SizedBox(width: AppConstants.valueDouble12),
                                      Selector<TaskDetailsController, DateTime?>(
                                        selector: (_, c) => c.selectedDueDate,
                                        builder: (context, dueDate, child) {
                                          final String dueDateDisplay = dueDate != null
                                              ? DateFormat('EEE, MMM d, h:mm a').format(dueDate)
                                              : 'Set due date';
                                          return TaskDetailChip(text: "Due $dueDateDisplay");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppConstants.valueDouble12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    const SizedBox(width: AppConstants.valueDouble12),
                                    TaskDetailChip(text: createAtDate),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.valueDouble25),
                                Selector<TaskDetailsController, int>(
                                  selector: (_, c) => c.subtasks.length,
                                  builder: (context, length, child) {
                                    return Column(
                                      children: List.generate(length, (index) {
                                        return SubtaskTile(
                                          isShownArrow: true,
                                          subtask: controller.subtasks[index],
                                          onRemove: () {
                                            controller.deleteSubtask(index);
                                            controller.removeSubtask(index);
                                          },
                                        );
                                      }),
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.subdirectory_arrow_right),
                                    const SizedBox(width: AppConstants.valueDouble12),
                                    GestureDetector(
                                      onTap: () => controller.addSubtask(),
                                      child: const Text(
                                        "Add subtasks",
                                        style: TextStyle(fontSize: AppConstants.valueDouble16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
