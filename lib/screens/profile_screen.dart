import 'package:flutter/material.dart';
import 'package:tasky/widgets/profile_header.widget.dart';
import 'package:tasky/widgets/profile_menu_item.widget.dart';
import 'package:tasky/widgets/profile_menu_section.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/widgets/button.widget.dart';
import 'package:tasky/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 4),
      body: Column(
        children: [
          ProfileHeader(
            name: 'Souleymane BARRO',
            email: 'souleymane@email.com',
            initials: 'SB',
            completedCount: '2',
            inProgressCount: '7',
            regularity: '86%',
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
                        onTap: () {},
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
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false,
                      );
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
                          Icon(Icons.logout, color: Color(0xFFFF6B5C), size: 18),
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
      ),
    );
  }
}