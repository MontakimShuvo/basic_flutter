import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

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

  // --- Task List CRUD ---

  Future<int> createTaskList(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('task_lists', row);
  }

  Future<List<Map<String, dynamic>>> getTaskLists() async {
    Database db = await database;
    return await db.query('task_lists', orderBy: 'position ASC');
  }

  Future<int> updateTaskList(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'task_lists',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTaskList(int id) async {
    Database db = await database;
    return await db.delete(
      'task_lists',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Tasks CRUD ---

  Future<int> createTask(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('tasks', row);
  }

  Future<List<Map<String, dynamic>>> getTasksByListId(int listId) async {
    Database db = await database;
    return await db.query(
      'tasks',
      where: 'list_id = ?',
      whereArgs: [listId],
      orderBy: 'position ASC',
    );
  }

  Future<int> updateTask(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'tasks',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Subtasks CRUD ---

  Future<int> createSubtask(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('subtasks', row);
  }

  Future<List<Map<String, dynamic>>> getSubtasksByTaskId(int taskId) async {
    Database db = await database;
    return await db.query(
      'subtasks',
      where: 'task_id = ?',
      whereArgs: [taskId],
      orderBy: 'position ASC',
    );
  }

  Future<int> updateSubtask(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'subtasks',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSubtask(int id) async {
    Database db = await database;
    return await db.delete(
      'subtasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
