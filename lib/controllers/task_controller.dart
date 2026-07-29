import 'package:tasky/models/task_model.dart';
import 'package:tasky/services/cache_service.dart';
import 'package:tasky/services/task_service.dart';

class TaskController {
  Future<List<Task>> fetchTasks() async {
    try {
      final tasks = await TaskService.getTasks();

      await CacheService.saveTasks(tasks);
      
      return tasks;
    } catch (e) {
      return CacheService.getCachedTasks();
    }
  }

  
  Future<Task> addTask({
    required String title,
    required String content,
    required String priority,
    required String color,
    DateTime? dueDate,
  }) {
    final task = Task(
      title: title,
      content: content,
      priority: priority,
      color: color,
      dueDate: dueDate,
    );
    return TaskService.createTask(task);
  }

  
  Future<Task> editTask({
    required int id,
    required String title,
    required String content,
    required String priority,
    required String color,
    DateTime? dueDate,
  }) {
    // Object avec les newa valeurs
    final task = Task(
      title: title,
      content: content,
      priority: priority,
      color: color,
      dueDate: dueDate,
    );
    return TaskService.updateTask(id, task);
  }

  Future<void> removeTask(int id) {
    return TaskService.deleteTask(id);
  }

  // Filter
  List<Task> filterTasks(List<Task> tasks, String filter) {
  final now = DateTime.now();

  switch (filter) {
    case 'Aujourd\'hui':
      return tasks.where((task) {
        if (task.dueDate == null) return false;
        final due = task.dueDate!.toLocal();
        return due.day == now.day &&
            due.month == now.month &&
            due.year == now.year;
      }).toList();

    case 'À venir':
      return tasks.where((task) {
        if (task.dueDate == null) return false;
        final due = task.dueDate!.toLocal();
        final today = DateTime(now.year, now.month, now.day);
        final taskDay = DateTime(due.year, due.month, due.day);
        return taskDay.isAfter(today);
      }).toList();

    case 'Terminées':
      return []; // En attente le champ isCompleted dans l'API Back

    default:
      return tasks;
  }
}

// Rechercher des tâches
List<Task> searchTasks(List<Task> tasks, String query) {
  if (query.isEmpty) return tasks;

  return tasks.where((task) {
    return task.title.toLowerCase().contains(query.toLowerCase());
  }).toList();
}

// Calcule les stats des tâches
Map<String, int> getStats(List<Task> tasks) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  int todayCount = 0;
  int upcomingCount = 0;

  for (final task in tasks) {
    if (task.dueDate == null) continue;
    final due = task.dueDate!.toLocal();
    final taskDay = DateTime(due.year, due.month, due.day);

    if (taskDay == today) {
      todayCount++;
    } else if (taskDay.isAfter(today)) {
      upcomingCount++;
    }
  }

  return {
    'total': tasks.length,
    'today': todayCount,
    'upcoming': upcomingCount,
  };
}
}