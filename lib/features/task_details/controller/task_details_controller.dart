import 'package:flutter/material.dart';
import '../../../data/database_service.dart';

class TaskDetailsController extends ChangeNotifier {
  final Map<String, dynamic> task;
  final DatabaseService _dbService = DatabaseService();

  late TextEditingController notesController;
  DateTime? selectedDueDate;

  TaskDetailsController({required this.task}) {
    notesController = TextEditingController(text: task['notes']);
    if (task['due_date'] != null) {
      selectedDueDate = DateTime.fromMillisecondsSinceEpoch(task['due_date']);
    }
  }

  void updateDueDate(DateTime date) {
    selectedDueDate = date;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    final int taskId = task['id'];
    final Map<String, dynamic> updatedRow = {
      'notes': notesController.text,
      'due_date': selectedDueDate?.millisecondsSinceEpoch,
    };

    await _dbService.updateTask(taskId, updatedRow);
  }

  void disposeControllers() {
    notesController.dispose();
  }
}
