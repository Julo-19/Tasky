import 'package:flutter/material.dart';
import 'package:tasky/controllers/task_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/widgets/notification_item.widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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

  String _formatDue(DateTime dueDate) {
    final due = dueDate.toLocal();
    final hour = due.hour.toString().padLeft(2, '0');
    final minute = due.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 3),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tasksFuture = _taskController.fetchTasks();
                      });
                    },
                    child: Text(
                      'Actualiser',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFF6B5C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                final sections =
                    _taskController.getUpcomingByDate(allTasks);

                if (sections.isEmpty) {
                  return Center(
                    child: Text(
                      'Aucun rappel à venir',
                      style: TextStyle(color: Colors.grey),
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
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: sections.entries.map((entry) {
                        final sectionTitle = entry.key;
                        final sectionTasks = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sectionTitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 12),
                            ...sectionTasks.map((task) {
                              return NotificationItem(
                                icon: Icons.access_time,
                                iconColor: _priorityColor(task.priority),
                                title: 'Rappel : ${task.title}',
                                description: task.content.isNotEmpty
                                    ? task.content
                                    : 'Prévue à ${_formatDue(task.dueDate!)}',
                                time: _formatDue(task.dueDate!),
                                isUnread: true,
                              );
                            }),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ),
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