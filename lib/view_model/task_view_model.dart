import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:plant_care_app/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class TaskViewModel extends ChangeNotifier {
  late Database _database;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskViewModel() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isDone INTEGER)',
        );
      },
    );

    await _loadTasks();
  }

  Future<void> _loadTasks() async {
    final List<Map<String, dynamic>> taskMaps = await _database.query('tasks');
    _tasks = taskMaps.map((map) => Task.fromMap(map)).toList();
    if (kDebugMode) {
      print("Loaded tasks: $_tasks");
    }
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final newTask = Task(title: title, isDone: false);
    await _database.insert(
      'tasks',
      newTask.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await _loadTasks();
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(int index) async {
    final task = _tasks[index];
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      isDone: !task.isDone,
    );

    await _database.update(
      'tasks',
      updatedTask.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );

    _tasks[index] = updatedTask;
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    final task = _tasks[index];
    await _database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
    _tasks.removeAt(index);
    notifyListeners();
  }
}
