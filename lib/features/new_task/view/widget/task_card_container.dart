import 'package:flutter/material.dart';

class TaskCardContainer extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const TaskCardContainer({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFF1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "No tasks yet",
                style: TextStyle(color: Colors.black, fontSize: 16),
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
              children: tasks.map((task) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        task['is_completed'] == 1
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task['is_completed'] == 1
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          task['title'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: task['is_completed'] == 1
                                ? TextDecoration.lineThrough
                                : null,
                            color: task['is_completed'] == 1
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
