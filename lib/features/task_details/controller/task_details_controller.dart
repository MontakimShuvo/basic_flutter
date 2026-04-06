import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/di/injector.dart';
import '../../../data/services/database_service.dart';
import '../../../data/model/subtask.dart';

class TaskDetailsController extends GetxController {
  final Map<String, dynamic> task;
  final DatabaseService _dbService = resolve<DatabaseService>();

  late TextEditingController notesController;
  final selectedDueDate = Rxn<DateTime>();
  final subtasks = <Subtask>[].obs;

  TaskDetailsController({required this.task});

  @override
  void onInit() {
    super.onInit();
    notesController = TextEditingController(text: task['notes']);
    if (task['due_date'] != null) {
      selectedDueDate.value = DateTime.fromMillisecondsSinceEpoch(task['due_date']);
    }
    _loadSubtasks();
  }

  Future<void> _loadSubtasks() async {
    final List<Map<String, dynamic>> maps = await _dbService.getSubtasksByTaskId(task['id']);
    subtasks.value = maps.map((map) {
      return Subtask(
        id: map['id'],
        title: map['title'],
        isCompleted: map['is_completed'],
        controller: TextEditingController(text: map['title']),
      );
    }).toList();
  }

  void updateDueDate(DateTime date) {
    selectedDueDate.value = date;
  }

  void addSubtask() {
    subtasks.add(Subtask(
      title: '',
      controller: TextEditingController(),
    ));
  }

  void removeSubtask(int index) {
    subtasks[index].isCompleted = subtasks[index].isCompleted == 1 ? 0 : 1;
    subtasks.removeAt(index);
  }

  Future<void> deleteSubtask(int index) async {
    await _dbService.deleteSubtask(subtasks[index].id!);
  }

  Future<void> saveChanges() async {
    final int taskId = task['id'];

    final Map<String, dynamic> updatedRow = {
      'notes': notesController.text,
      'due_date': selectedDueDate.value?.millisecondsSinceEpoch,
    };
    await _dbService.updateTask(taskId, updatedRow);

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

  @override
  void onClose() {
    notesController.dispose();
    for (var subtask in subtasks) {
      subtask.controller?.dispose();
    }
    super.onClose();
  }
}