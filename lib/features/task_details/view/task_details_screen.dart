import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/app_constants.dart';
import '../../../widgets/calendar_widget/task_calendar_sheet.dart';
import '../../../widgets/text_field/common_input_field.dart';
import '../../../utils/size_config.dart';
import '../controller/task_details_controller.dart';
import 'widget/subtask_tile.dart';

class TaskDetailsScreen extends GetView<TaskDetailsController> {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String title = controller.task['title'] ?? 'No title';
    final int? createAtMillis = controller.task['created_at'];

    final String createAtDate = createAtMillis != null
        ? DateFormat('EEE, MMM d')
            .format(DateTime.fromMillisecondsSinceEpoch(createAtMillis))
        : '';

    return Obx(() {
      final String dueDateDisplay = controller.selectedDueDate.value != null
          ? DateFormat('EEE, MMM d, h:mm a')
              .format(controller.selectedDueDate.value!)
          : 'Set due date';

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.valueDouble12,
                    ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.valueDouble12,
                      ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                              onTap: () => _openTaskCalendar(context),
                              child: Row(
                                children: [
                                  const Icon(Icons.adjust),
                                  const SizedBox(width: AppConstants.valueDouble12),
                                  chip("Due $dueDateDisplay"),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppConstants.valueDouble12),
                            Row(
                              children: [
                                const Icon(Icons.access_time),
                                const SizedBox(width: AppConstants.valueDouble12),
                                chip(createAtDate),
                              ],
                            ),
                            const SizedBox(height: AppConstants.valueDouble25),
                            ...List.generate(controller.subtasks.length, (index) {
                              return SubtaskTile(
                                isShownArrow: true,
                                subtask: controller.subtasks[index],
                                onRemove: () {
                                  controller.deleteSubtask(index);
                                  controller.removeSubtask(index);
                                },
                              );
                            }),
                            Row(
                              children: [
                                Icon(Icons.subdirectory_arrow_right),
                                SizedBox(width: AppConstants.valueDouble12),
                                GestureDetector(
                                  onTap: () {
                                    controller.addSubtask();
                                  },
                                  child: const Text(
                                    "Add subtasks",
                                    style: TextStyle(
                                      fontSize: AppConstants.valueDouble16,
                                    ),
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
    });
  }

  void _openTaskCalendar(BuildContext context) async {
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

  Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.valueDouble14,
        vertical: AppConstants.valueDouble8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(AppConstants.valueDouble12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: AppConstants.valueDouble6),
          const Icon(Icons.close, size: AppConstants.valueDouble18),
        ],
      ),
    );
  }
}