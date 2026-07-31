import 'package:flutter/material.dart';
import 'package:tasky/controllers/auth_controller.dart';
import 'package:tasky/controllers/task_controller.dart';
import 'package:tasky/widgets/profile_header.widget.dart';
import 'package:tasky/widgets/profile_menu_item.widget.dart';
import 'package:tasky/widgets/profile_menu_section.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/screens/login_screen.dart';
import 'package:tasky/screens/personal_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = AuthController();
  final TaskController _taskController = TaskController();
  late Future<Map<String, dynamic>> _profileFuture;
  Map<String, int> _stats = {'total': 0, 'today': 0, 'upcoming': 0};

  @override
  void initState() {
    super.initState();
    _profileFuture = _authController.getProfile();
    _loadStats();
  }

  // Looad les stats tasks
  Future<void> _loadStats() async {
    try {
      final tasks = await _taskController.fetchTasks();
      if (mounted) {
        setState(() {
          _stats = _taskController.getStats(tasks);
        });
      }
    } catch (e) {
      // En cas d'erreur on garde les stats à 0
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 4),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final profile = snapshot.data!;
          final nom = profile['nom'] ?? '';
          final prenom = profile['prenom'] ?? '';
          final email = profile['email'] ?? '';
          final photo = profile['photo'] as String?;
          final fullName = '$prenom $nom';
          final initials = _getInitials(prenom, nom);

          return Column(
            children: [
              ProfileHeader(
                name: fullName,
                email: email,
                initials: initials,
                photoBase64: photo,
                completedCount: '${_stats['total']}',
                inProgressCount: '${_stats['today']}',
                regularity: '${_stats['upcoming']}',
                onEditTap: () {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      ProfileMenuSection(
                        items: [
                          ProfileMenuItem(
                            icon: Icons.person_outline,
                            iconColor: Color(0xFF6C63FF),
                            title: 'Informations personnelles',
                            onTap: () async {
                              final updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PersonalInfoScreen(
                                    nom: nom,
                                    prenom: prenom,
                                    email: email,
                                  ),
                                ),
                              );
                              if (updated == true) {
                                setState(() {
                                  _profileFuture = _authController.getProfile();
                                });
                              }
                            },
                          ),
                          ProfileMenuItem(
                            icon: Icons.notifications_outlined,
                            iconColor: Colors.orange,
                            title: 'Notifications',
                            subtitle: 'Activées',
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.flag_outlined,
                            iconColor: Color(0xFFFF6B5C),
                            title: 'Priorités par défaut',
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.repeat,
                            iconColor: Colors.green,
                            title: 'Tâches récurrentes',
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ProfileMenuSection(
                        items: [
                          ProfileMenuItem(
                            icon: Icons.light_mode_outlined,
                            iconColor: Colors.amber,
                            title: 'Apparence',
                            subtitle: 'Clair',
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.settings_outlined,
                            iconColor: Colors.grey,
                            title: 'Préférences',
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.ios_share,
                            iconColor: Color(0xFFFF6B5C),
                            title: 'Inviter des amis',
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () async {
                          await _authController.logout();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout,
                                  color: Color(0xFFFF6B5C), size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Se déconnecter',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF6B5C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Génère les initiales du nom
  String _getInitials(String prenom, String nom) {
    final p = prenom.isNotEmpty ? prenom[0] : '';
    final n = nom.isNotEmpty ? nom[0] : '';
    return '$p$n'.toUpperCase();
  }
}