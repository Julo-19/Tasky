import 'package:flutter/material.dart';
import 'package:tasky/widgets/home_header.widget.dart';
import 'package:tasky/widgets/home_filter.widget.dart';
import 'package:tasky/widgets/task_item.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/services/task_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = TaskService.getTasks();
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
                      _tasksFuture = TaskService.getTasks();
                    });
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskItem(
                        title: task.title,
                        description: task.content,
                        time: '',
                        priority: Colors.red,
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