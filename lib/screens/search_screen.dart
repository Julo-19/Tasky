import 'package:flutter/material.dart';
import 'package:tasky/controllers/task_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TaskController _taskController = TaskController();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Task>> _tasksFuture;
  String _query = '';

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
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 1),
      body: Column(
        children: [
          // Header
          SafeArea(
            bottom: false,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Recherche',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _query = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Recherche par titre...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Résultats
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
                final results = _taskController.searchTasks(allTasks, _query);

                if (results.isEmpty) {
                  return Center(
                    child: Text(
                      'Aucun résultat',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(24),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final task = results[index];
                    return TaskItem(
                      task: task,
                      time: _formatTime(task.dueDate),
                      priority: _priorityColor(task.priority),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}