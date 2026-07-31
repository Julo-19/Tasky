import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasky/models/task_model.dart';
import 'package:tasky/services/cache_service.dart';
import 'dart:io' show Platform;

class TaskService {
  // static const String baseUrl = 'http://localhost:3000';

    static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  // Construit les headers avec le token
  static Map<String, String> _headers() {
    final token = CacheService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Récupérer toutes les tâches
  static Future<List<Task>> getTasks() async {
    final response = await http.get(
      Uri.parse('$baseUrl/task'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des taches');
    }
  }

  // Créer une tâche
  static Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/task'),
      headers: _headers(),
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la creation de la tache');
    }
  }

  // Modifier une tâche
  static Future<Task> updateTask(int id, Task task) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/task/$id'),
      headers: _headers(),
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la modification de la tache');
    }
  }

  // Supprimer une tâche
  static Future<void> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/task/$id'),
      headers: _headers(),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erreur lors de la suppression de la tache');
    }
  }
}