import 'package:flutter/material.dart';
import '../../../data/database_service.dart';

class NewTaskController extends ChangeNotifier {
  final int? id;
  final String taskName;
  final List<Map<String, dynamic>> items = [];
  final DatabaseService _dbService = DatabaseService();

  NewTaskController({this.id, required this.taskName}) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    if (id != null) {
      final tasks = await _dbService.getTasksByListId(id!);
      items.clear();
      items.addAll(tasks);
      notifyListeners();
    }
  }

  Future<void> addItem() async {
    if (id == null) return;

    final String taskTitle = "New item ${items.length + 1} for $taskName";

    final newTask = {
      'list_id': id,
      'title': taskTitle,
      'is_completed': 0,
      'position': items.length,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    final taskId = await _dbService.createTask(newTask);

    items.add({...newTask, 'id': taskId});

    notifyListeners();
  }
}
