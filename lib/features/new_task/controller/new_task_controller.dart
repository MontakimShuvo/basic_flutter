import 'package:flutter/material.dart';
import '../../../data/database_service.dart';
import '../../../data/model/subtask.dart';

class NewTaskController extends ChangeNotifier {
  final int? id;
  final String taskName;
  final List<Map<String, dynamic>> items = [];
  final DatabaseService _dbService = DatabaseService();

  List<Subtask> subtasks = [];

  NewTaskController({this.id, required this.taskName}) {
    loadTasks();
  }

  Future<List<Map<String, dynamic>>> loadSubtasks(int taskId) async {
    return await _dbService.getSubtasksByTaskId(taskId);
  }

  Future<void> deleteSubtask(int subtaskId) async {
    await _dbService.deleteSubtask(subtaskId);
    notifyListeners();
  }

  Future<void> toggleSubtask(int subtaskId, int isCompleted) async {
    await _dbService.updateSubtask(subtaskId, {'is_completed': isCompleted == 1 ? 0 : 1});
    notifyListeners();
  }

  Future<void> loadTasks() async {
    if (id != null) {
      final tasks = await _dbService.getTasksByListId(id!);
      items.clear();
      items.addAll(tasks);
      notifyListeners();
    }
  }

  Future<void> addItem({required String taskTitle, String? notes, DateTime? dueDate}) async {
    if (id == null) return;

    final newTask = {
      'list_id': id,
      'title': taskTitle,
      'notes': notes,
      'due_date': dueDate?.millisecondsSinceEpoch,
      'is_completed': 0,
      'position': items.length,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    final taskId = await _dbService.createTask(newTask);

    items.add({...newTask, 'id': taskId});

    notifyListeners();
  }
}
