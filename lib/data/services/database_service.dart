import 'package:sqflite/sqflite.dart';
import 'database_service_impl.dart';

abstract class DatabaseService {
  Future<int> createTaskList(Map<String, dynamic> row);
  Future<List<Map<String, dynamic>>> getTaskLists();
  Future<int> updateTaskList(int id, Map<String, dynamic> row);
  Future<int> deleteTaskList(int id);

  Future<int> createTask(Map<String, dynamic> row);
  Future<List<Map<String, dynamic>>> getTasksByListId(int listId);
  Future<int> updateTask(int id, Map<String, dynamic> row);
  Future<int> deleteTask(int id);

  Future<int> createSubtask(Map<String, dynamic> row);
  Future<List<Map<String, dynamic>>> getSubtasksByTaskId(int taskId);
  Future<int> updateSubtask(int id, Map<String, dynamic> row);
  Future<int> deleteSubtask(int id);

  Future<List<Map<String, dynamic>>> getFavouriteTasks();

}
