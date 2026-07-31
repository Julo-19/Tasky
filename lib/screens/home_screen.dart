import 'package:flutter/material.dart';
import 'package:tasky/widgets/home_header.widget.dart';
import 'package:tasky/widgets/home_filter.widget.dart';
import 'package:tasky/widgets/filter_bottom_sheet.widget.dart';
import 'package:tasky/widgets/task_item.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/controllers/task_controller.dart';
import 'package:tasky/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = TaskController();
  final AuthController _authController = AuthController();
  late Future<List<Task>> _tasksFuture;
  String _selectedFilter = 'Aujourd\'hui';
  String _selectedPriority = 'Toutes';
  String _prenom = '';

  @override
  void initState() {
    super.initState();
    _tasksFuture = _taskController.fetchTasks();
    _loadProfile();
  }

  // Charge le prénom de l'utilisateur
  Future<void> _loadProfile() async {
    try {
      final profile = await _authController.getProfile();
      if (mounted) {
        setState(() {
          _prenom = profile['prenom'] ?? '';
        });
      }
    } catch (e) {
      // En cas d'erreur, on garde le prénom vide
    }
  }

  // Ouvre le bottom sheet de filtres et récupère le choix
  Future<void> _openFilterSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        selectedPriority: _selectedPriority,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedPriority = result;
      });
    }
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

    if (local.day == now.day &&
        local.month == now.month &&
        local.year == now.year) {
      return 'Aujourd\'hui $time';
    }

    final tomorrow = now.add(Duration(days: 1));
    if (local.day == tomorrow.day &&
        local.month == tomorrow.month &&
        local.year == tomorrow.year) {
      return 'Demain $time';
    }

    return '${local.day}/${local.month} $time';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 0),
      body: Column(
        children: [
          HomeHeader(
            prenom: _prenom,
            onFilterTap: _openFilterSheet,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: HomeFilter(
              onChanged: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _tasksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                }

                final allTasks = snapshot.data!;
                final byDate =
                    _taskController.filterTasks(allTasks, _selectedFilter);
                final tasks = _taskController.filterByPriority(
                    byDate, _selectedPriority);

                if (tasks.isEmpty) {
                  return RefreshIndicator(
                    color: Color(0xFFFF6B5C),
                    onRefresh: () async {
                      setState(() {
                        _tasksFuture = _taskController.fetchTasks();
                      });
                    },
                    child: ListView(
                      children: [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            _selectedFilter == 'Terminées'
                                ? 'Aucune tâche terminée'
                                : 'Aucune tâche ${_selectedFilter == 'À venir' ? 'à venir' : 'pour aujourd\'hui'}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
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