import 'package:flutter/material.dart';
import 'package:tasky/widgets/home_header.widget.dart';
import 'package:tasky/widgets/home_filter.widget.dart';
import 'package:tasky/widgets/task_item.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/controllers/task_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = TaskController();
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = _taskController.fetchTasks();
  }

  Color _priorityColor(String priority) {
  switch (priority) {
    case 'Haute':
      return Colors.red;
    case 'Moyenne':
      return Colors.orange;
    case 'Basse':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

String _formatTime(DateTime? dueDate) {
  if (dueDate == null) return '';
  final local = dueDate.toLocal();
  final now = DateTime.now();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  final time = '$hour:$minute';

  // Aujourd'hui
  if (local.day == now.day && local.month == now.month && local.year == now.year) {
    return 'Aujourd\'hui $time';
  }

  
  final tomorrow = now.add(Duration(days: 1));
  if (local.day == tomorrow.day && local.month == tomorrow.month && local.year == tomorrow.year) {
    return 'Demain $time';
  }

  // Sinon la date
  return '${local.day}/${local.month} $time';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 0),
      body: Column(
        children: [
          HomeHeader(),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: HomeFilter(),
          ),
          SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _tasksFuture,
              builder: (context, snapshot) {
                // En attente de la réponse
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // Erreur
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                }

                // Données reçues
                final tasks = snapshot.data!;

                if (tasks.isEmpty) {
                  return Center(child: Text('Aucune tâche pour le moment'));
                }

                return RefreshIndicator(
                  color: Color(0xFFFF6B5C),
                  onRefresh: () async {
                    setState(() {
                      _tasksFuture = _taskController.fetchTasks();
                    });
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskItem(
                        task: task,
                        time: _formatTime(task.dueDate),
                        priority: _priorityColor(task.priority),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}