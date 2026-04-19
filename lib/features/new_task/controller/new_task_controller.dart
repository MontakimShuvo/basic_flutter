import 'package:flutter/material.dart';
import 'package:untitled/di/injector.dart';
import '../../../data/services/database_service.dart';
import '../../../data/model/subtask.dart';

class NewTaskController extends ChangeNotifier {
  final int? id;
  final String taskName;
  final bool isFavouriteTab;
  final List<Map<String, dynamic>> items = [];
  final DatabaseService _dbService = resolve<DatabaseService>();
  final VoidCallback? onDeleteList;

  List<Subtask> subtasks = [];
  String currentSort = "my_order";

  bool isCompletedExpanded = false;

  NewTaskController({
    this.id,
    required this.taskName,
    this.isFavouriteTab = false,
    this.onDeleteList,
  }) {
    loadTasks();
  }

  void toggleCompletedExpanded() {
    isCompletedExpanded = !isCompletedExpanded;
    notifyListeners();
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

  Future<void> toggleTask(int taskId, int isCompleted) async {
    await _dbService.updateTask(taskId, {'is_completed': isCompleted == 1 ? 0 : 1});
    await loadTasks();
  }

  Future<void> toggleFavourite(int taskId, int isFavourite) async {
    await _dbService.updateTask(taskId, {'is_favourite': isFavourite == 1 ? 0 : 1});
    await loadTasks();
  }

  Future<void> loadTasks() async {
    List<Map<String, dynamic>> tasks;
    if (isFavouriteTab) {
      tasks = await _dbService.getFavouriteTasks();
    } else if (id != null) {
      tasks = await _dbService.getTasksByListId(id!);
    } else {
      return;
    }

    items.clear();
    items.addAll(tasks);
    _applySort();
    notifyListeners();
  }

  Future<void> deleteList() async {
    if (id != null && !isFavouriteTab) {
      await _dbService.deleteTaskList(id!);
      onDeleteList?.call();
    }
  }

  void sortTasks(String sortType) {
    currentSort = sortType;
    _applySort();
    notifyListeners();
  }

  void _applySort() {
    switch (currentSort) {
      case "date":
        items.sort((a, b) => (a['created_at'] ?? 0).compareTo(b['created_at'] ?? 0));
        break;
      case "dead_line":
        items.sort((a, b) {
          if (a['due_date'] == null && b['due_date'] == null) return 0;
          if (a['due_date'] == null) return 1;
          if (b['due_date'] == null) return -1;
          return (a['due_date'] as int).compareTo(b['due_date'] as int);
        });
        break;
      case "title":
        items.sort((a, b) => (a['title'] ?? '').toLowerCase().compareTo((b['title'] ?? '').toLowerCase()));
        break;
      case "my_order":
      default:
        items.sort((a, b) => (a['position'] ?? 0).compareTo(b['position'] ?? 0));
        break;
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
      'is_favourite': 0,
      'position': items.length,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    final taskId = await _dbService.createTask(newTask);

    items.add({...newTask, 'id': taskId});
    _applySort();
    notifyListeners();
  }
}
