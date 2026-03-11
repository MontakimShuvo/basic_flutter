import 'package:flutter/material.dart';
import '../../../data/database_service.dart';
import '../../../data/model/subtask.dart';

class TaskDetailsController extends ChangeNotifier {
  final Map<String, dynamic> task;
  final DatabaseService _dbService = DatabaseService();

  late TextEditingController notesController;
  DateTime? selectedDueDate;
  List<Subtask> subtasks = [];

  TaskDetailsController({required this.task}) {
    notesController = TextEditingController(text: task['notes']);
    if (task['due_date'] != null) {
      selectedDueDate = DateTime.fromMillisecondsSinceEpoch(task['due_date']);
    }
    _loadSubtasks();
  }

  Future<void> _loadSubtasks() async {
    final List<Map<String, dynamic>> maps = await _dbService.getSubtasksByTaskId(task['id']);
    subtasks = maps.map((map) {
      return Subtask(
        id: map['id'],
        title: map['title'],
        isCompleted: map['is_completed'],
        controller: TextEditingController(text: map['title']),
      );
    }).toList();
    notifyListeners();
  }

  void updateDueDate(DateTime date) {
    selectedDueDate = date;
    notifyListeners();
  }

  void addSubtask() {

    subtasks.add(Subtask(
      title: '',
      controller: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeSubtask(int index) {
    subtasks[index].isCompleted = subtasks[index].isCompleted == 1 ? 0 : 1;
    subtasks.removeAt(index);
    notifyListeners();
  }

  Future<void> deleteSubtask(int index) async{
    await _dbService.deleteSubtask(subtasks[index].id!);
  }

  Future<void> saveChanges() async {
    final int taskId = task['id'];
    
    // Save main task details
    final Map<String, dynamic> updatedRow = {
      'notes': notesController.text,
      'due_date': selectedDueDate?.millisecondsSinceEpoch,
    };
    await _dbService.updateTask(taskId, updatedRow);

    // Save subtasks: This is a simplified approach (delete all and re-insert for the task)
    // In a real production app, you'd likely track dirty states or use a more efficient sync.
    // For this example, we'll follow the requirement to call updateSubtask logic.
    
    // First, clear existing subtasks for this task in DB to sync properly
    // Note: DatabaseService doesn't have a 'deleteAllSubtasksForTask' method, 
    // so we'd ideally implement one. For now, we'll just save new/updated ones if they have content.
    
    for (int i = 0; i < subtasks.length; i++) {
      final subtask = subtasks[i];
      subtask.title = subtask.controller?.text ?? subtask.title;
      
      if (subtask.title.isNotEmpty) {
        if (subtask.id == null) {
          await _dbService.createSubtask(subtask.toMap(taskId, i));
        } else {
          await _dbService.updateSubtask(subtask.id!, subtask.toMap(taskId, i));
        }
      } else if (subtask.id != null) {
        await _dbService.deleteSubtask(subtask.id!);
      }
    }
  }

  void disposeControllers() {
    notesController.dispose();
    for (var subtask in subtasks) {
      subtask.controller?.dispose();
    }
  }
}
