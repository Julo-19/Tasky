import 'package:flutter/material.dart';
import 'package:tasky/screens/new_task_screen.dart';
import 'package:tasky/screens/search_screen.dart';
import 'package:tasky/screens/notifications_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/home_screen.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;

  const BottomNav({super.key, this.currentIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 0, Icons.list, 'Tâches'),
            _buildNavItem(context, 1, Icons.search, 'Recherche'),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NewTaskScreen()),
                );
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFFF6B5C),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            _buildNavItem(context, 3, Icons.notifications_outlined, 'Alertes'),
            _buildNavItem(context, 4, Icons.person_outline, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    bool isSelected = index == widget.currentIndex;
    return GestureDetector(
      onTap: () {
        if (index == widget.currentIndex) return;

        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SearchScreen()),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => NotificationsScreen()),
          );
        } else if (index == 4) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ProfileScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xFFFF6B5C) : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? Color(0xFFFF6B5C) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}