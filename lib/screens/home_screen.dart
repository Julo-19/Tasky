import 'package:flutter/material.dart';
import 'package:tasky/widgets/home_header.widget.dart';
import 'package:tasky/widgets/home_filter.widget.dart';
import 'package:tasky/widgets/task_item.widget.dart';
import '../widgets/bottom_nav_bar.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(),
      body: Column(
        children: [
          HomeHeader(),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: HomeFilter(),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                TaskItem(
                  title: 'Créer les maquettes sur Figma',
                  description: 'Faire le prototypage interactif',
                  time: '10:00',
                  priority: Colors.red,
                ),
                TaskItem(
                  title: 'Initialiser le projet Flutter',
                  description: 'Configurer la structure des dossiers',
                  time: '14:00',
                  priority: Colors.red,
                ),
                TaskItem(
                  title: 'Authentification',
                  description: 'Implémenter écran de connexion et d\'inscription',
                  time: '16:00',
                  priority: Colors.orange,
                ),
                TaskItem(
                  title: 'Gestion des tâches',
                  description: 'Créer une tâche (titre, description, date, priorité)',
                  time: '19:00',
                  priority: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}