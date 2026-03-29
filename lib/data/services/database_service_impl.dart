import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_service.dart';

class DatabaseServiceImpl implements DatabaseService {
  static final DatabaseServiceImpl _instance = DatabaseServiceImpl._internal();
  static Database? _database;

  factory DatabaseServiceImpl() => _instance;

  DatabaseServiceImpl._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Task Lists Table
    await db.execute('''
      CREATE TABLE task_lists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        position INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL
      )
    ''');

    // Tasks Table
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        list_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        notes TEXT,
        due_date INTEGER,
        is_completed INTEGER DEFAULT 0,
        is_favourite INTEGER DEFAULT 0,
        position INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (list_id) REFERENCES task_lists (id) ON DELETE CASCADE
      )
    ''');

    // Subtasks Table
    await db.execute('''
      CREATE TABLE subtasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        is_completed INTEGER DEFAULT 0,
        position INTEGER DEFAULT 0,
        FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
      )
    ''');
  }

  @override
  Future<int> createTaskList(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('task_lists', row);
  }

  @override
  Future<List<Map<String, dynamic>>> getTaskLists() async {
    Database db = await database;
    return await db.query('task_lists', orderBy: 'position ASC');
  }

  @override
  Future<int> updateTaskList(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'task_lists',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteTaskList(int id) async {
    Database db = await database;
    return await db.delete(
      'task_lists',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> createTask(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('tasks', row);
  }

  @override
  Future<List<Map<String, dynamic>>> getTasksByListId(int listId) async {
    Database db = await database;
    return await db.query(
      'tasks',
      where: 'list_id = ?',
      whereArgs: [listId],
      orderBy: 'position ASC',
    );
  }

  @override
  Future<int> updateTask(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'tasks',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> createSubtask(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('subtasks', row);
  }

  @override
  Future<List<Map<String, dynamic>>> getSubtasksByTaskId(int taskId) async {
    Database db = await database;
    return await db.query(
      'subtasks',
      where: 'task_id = ?',
      whereArgs: [taskId],
      orderBy: 'position ASC',
    );
  }

  @override
  Future<int> updateSubtask(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'subtasks',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteSubtask(int id) async {
    Database db = await database;
    return await db.delete(
      'subtasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getFavouriteTasks() async {
    Database db = await database;
    return await db.query(
      'tasks',
      where: 'is_favourite = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );
  }
}
