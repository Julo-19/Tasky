import 'package:tasky/models/task_model.dart';
import 'package:tasky/services/cache_service.dart';
import 'package:tasky/services/task_service.dart';
import 'package:tasky/services/notification_service.dart';
import 'package:share_plus/share_plus.dart';

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
  }) async {
    final task = Task(
      title: title,
      content: content,
      priority: priority,
      color: color,
      dueDate: dueDate,
    );

    final createdTask = await TaskService.createTask(task);

    // Meme si la notif échoue la tâche reste créée
    if (createdTask.dueDate != null &&
        createdTask.dueDate!.isAfter(DateTime.now())) {
      try {
        await NotificationService.scheduleNotification(
          id: createdTask.id ?? 0,
          title: 'Rappel de tâche',
          body: createdTask.title,
          scheduledDate: createdTask.dueDate!,
        );
      } catch (e) {
        // On ignore l'erreur
      }
    }

    return createdTask;
  }

  Future<Task> editTask({
    required int id,
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
    return TaskService.updateTask(id, task);
  }

  Future<void> removeTask(int id) {
    return TaskService.deleteTask(id);
  }

  // Filtrer les tâches par date
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
        return []; // En attente le champ isCompleted

      default:
        return tasks;
    }
  }

  // Filtrer les tâches par priorité
  List<Task> filterByPriority(List<Task> tasks, String priority) {
    if (priority == 'Toutes') return tasks;
    return tasks.where((task) => task.priority == priority).toList();
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

  // Share une tâche
  Future<void> shareTask(Task task) async {
    final buffer = StringBuffer();
    buffer.writeln('📋 ${task.title}');
    if (task.content.isNotEmpty) {
      buffer.writeln(task.content);
    }
    if (task.dueDate != null) {
      final due = task.dueDate!.toLocal();
      final formatted =
          '${due.day.toString().padLeft(2, '0')}/${due.month.toString().padLeft(2, '0')}/${due.year} à ${due.hour.toString().padLeft(2, '0')}:${due.minute.toString().padLeft(2, '0')}';
      buffer.writeln('📅 $formatted');
    }
    buffer.writeln('Priorité : ${task.priority}');
    buffer.write('— Partagé depuis Tasky');

    await Share.share(buffer.toString());
  }

  // Regroupe les tâches à venir pour Notif
  Map<String, List<Task>> getUpcomingByDate(List<Task> tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));

    final Map<String, List<Task>> sections = {};

    final upcoming = tasks.where((task) => task.dueDate != null).toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    for (final task in upcoming) {
      final due = task.dueDate!.toLocal();
      final day = DateTime(due.year, due.month, due.day);

      String section;
      if (day == today) {
        section = 'AUJOURD\'HUI';
      } else if (day == tomorrow) {
        section = 'DEMAIN';
      } else if (day.isAfter(today)) {
        section =
            '${due.day.toString().padLeft(2, '0')}/${due.month.toString().padLeft(2, '0')}';
      } else {
        continue;
      }

      sections.putIfAbsent(section, () => []).add(task);
    }

    return sections;
  }
}