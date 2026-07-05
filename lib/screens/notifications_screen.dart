import 'package:flutter/material.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';
import 'package:tasky/widgets/notification_item.widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
                    onTap: () {},
                    child: Text(
                      'Tout lire',
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AUJOURD\'HUI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  NotificationItem(
                    icon: Icons.access_time,
                    iconColor: Colors.red,
                    title: 'Rappel : Réunion équipe design',
                    description: 'Commence dans 30 minutes — 10:00',
                    time: 'À l\'instant',
                    isUnread: true,
                  ),
                  NotificationItem(
                    icon: Icons.flag,
                    iconColor: Colors.red,
                    title: 'Échéance proche',
                    description: '« Appeler le client Dupont » est due aujourd\'hui.',
                    time: 'Il y a 1 h',
                    isUnread: true,
                  ),
                  NotificationItem(
                    icon: Icons.ios_share,
                    iconColor: Colors.orange,
                    title: 'Liste partagée',
                    description: 'Thomas a partagé « Projet Q3 » avec vous.',
                    time: 'Il y a 3 h',
                  ),
                  NotificationItem(
                    icon: Icons.check,
                    iconColor: Colors.green,
                    title: 'Tâche terminée 🎉',
                    description: 'Vous avez terminé « Réserver le restaurant ».',
                    time: 'Hier',
                  ),
                  NotificationItem(
                    icon: Icons.notifications,
                    iconColor: Colors.orange,
                    title: 'Récapitulatif du jour',
                    description: 'Vous avez 4 tâches prévues aujourd\'hui.',
                    time: 'Hier',
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