import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item.widget.dart';
import 'package:tasky/widgets/bottom_nav_bar.widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNav(currentIndex: 1),
      body: Column(
        children: [
          // Header blanc
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
          // Contenu sur fond gris
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECHERCHES RÉCENTES',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Projet', 'Réunion', 'Études'].map((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history, size: 14, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              item,
                              style: TextStyle(fontSize: 13, color: Color(0xFF1A1A2E)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'SUGGESTIONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  TaskItem(
                    task: Task(
                      title: 'Créer les maquettes sur Figma',
                      content: 'Faire le prototypage interactif',
                      priority: 'Haute',
                      color: 'red',
                    ),
                    time: '10:00',
                    priority: Colors.red,
                  ),
                  TaskItem(
                    task: Task(
                      title: 'Initialiser le projet Flutter',
                      content: 'Configurer la structure des dossiers',
                      priority: 'Haute',
                      color: 'red',
                    ),
                    time: '14:00',
                    priority: Colors.red,
                  ),
                  TaskItem(
                    task: Task(
                      title: 'Authentification',
                      content: 'Implémenter écran de connexion et d\'inscription',
                      priority: 'Moyenne',
                      color: 'orange',
                    ),
                    time: '16:00',
                    priority: Colors.orange,
                  ),
                  TaskItem(
                    task: Task(
                      title: 'Gestion des tâches',
                      content: 'Créer une tâche (titre, description, date, priorité)',
                      priority: 'Basse',
                      color: 'green',
                    ),
                    time: '19:00',
                    priority: Colors.green,
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