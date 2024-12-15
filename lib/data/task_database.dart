import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabaseHelper {
  static final TaskDatabaseHelper _instance = TaskDatabaseHelper._internal();
  factory TaskDatabaseHelper() => _instance;
  late Database _database;

  TaskDatabaseHelper._internal();

  // Initialize the database
  Future<void> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
      },
    );
  }

  Future<List<String>> loadTasks() async {
    final List<Map<String, dynamic>> taskMaps = await _database.query('tasks');
    return List.generate(taskMaps.length, (index) {
      return taskMaps[index]['name'] as String;
    });
  }

  Future<void> addTask(String task) async {
    await _database.insert(
      'tasks',
      {'name': task},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(String taskName) async {
    await _database.delete(
      'tasks',
      where: 'name = ?',
      whereArgs: [taskName],
    );
  }
}
