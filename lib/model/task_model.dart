class Task {
  final int? id;
  final String title;
  final bool isDone;

  Task({this.id, required this.title, required this.isDone});

  // Convert a Task to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone ? 1 : 0,
    };
  }

  // Convert a Map to a Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      isDone: map['isDone'] == 1,
    );
  }
}
