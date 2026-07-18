import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasky/models/task_model.dart';

class TaskService {
  static const String baseUrl = 'http://localhost:3000';


  static Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/task'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des taches');
    }
  }

  
  static Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/task'),
      headers: {'Content-Type' : 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la creation de la tache');
    }
  }

 
static Future<Task> updateTask(int id, Task task) async {
  final response = await http.patch(
    Uri.parse('$baseUrl/task/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(task.toJson()),
  );

  if (response.statusCode == 200) {
    return Task.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erreur lors de la modification de la tache');
  }
}

static Future<void> deleteTask(int id) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/task/$id'),
    );

    if(response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erreur lors de la suppression de la tache');
    }
}

}