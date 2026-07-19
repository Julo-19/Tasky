import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:tasky/models/task_model.dart';

class CacheService {
  static const String _boxName = 'tasksBox';
  static const String _tasksKey = 'tasks';


  static Future<void> saveTasks(List<Task> tasks) async {
    final box = Hive.box(_boxName);
    final jsonList = tasks.map((task) => task.toJson()).toList();
    await box.put(_tasksKey, jsonEncode(jsonList));
  }


  static List<Task> getCachedTasks() {
    final box = Hive.box(_boxName);
    final jsonString = box.get(_tasksKey);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Task.fromJson(json)).toList();
  }
}