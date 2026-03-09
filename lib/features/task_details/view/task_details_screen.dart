import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/app_constants.dart';
import '../../../utils/size_config.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String title = task['title'] ?? 'No title';
    final String notes = task['notes'] ?? 'No notes';
    final int? dueDateMillis = task['due_date'];
    final String dueDate = dueDateMillis != null 
        ? DateFormat('EEE, MMM d').format(DateTime.fromMillisecondsSinceEpoch(dueDateMillis))
        : 'Set due date';

    return Scaffold(
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
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.star_border),
                        SizedBox(width: AppConstants.valueDouble16),
                        Icon(Icons.more_vert),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.valueDouble20),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppConstants.valueDouble12),
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
                          Icon(Icons.arrow_drop_down)
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notes_outlined),
                          const SizedBox(width: AppConstants.valueDouble12),
                          Expanded(
                            child: Text(
                              notes,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: AppConstants.valueDouble20),
                      Row(
                        children: [
                          const Icon(Icons.adjust),
                          const SizedBox(width: AppConstants.valueDouble12),
                          chip("Due $dueDate"),
                        ],
                      ),
                      const SizedBox(height: AppConstants.valueDouble12),
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: AppConstants.valueDouble12),
                          chip(dueDate),
                        ],
                      ),
                      const SizedBox(height: AppConstants.valueDouble25),
                      Row(
                        children: const [
                          Icon(Icons.subdirectory_arrow_right),
                          SizedBox(width: AppConstants.valueDouble12),
                          Text(
                            "Add subtasks",
                            style: TextStyle(fontSize: AppConstants.valueDouble16),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.valueDouble14, vertical: AppConstants.valueDouble8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(AppConstants.valueDouble12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: AppConstants.valueDouble6),
          const Icon(Icons.close, size: AppConstants.valueDouble18)
        ],
      ),
    );
  }
}
