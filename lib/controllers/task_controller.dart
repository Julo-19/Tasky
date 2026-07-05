import 'package:tasky/models/task_model.dart';
import 'package:tasky/services/task_service.dart';

class TaskController {
  // Récupérer les tâches
  Future<List<Task>> fetchTasks() {
    return TaskService.getTasks();
  }

  // Créer une tâche
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
}