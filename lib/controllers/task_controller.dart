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
}