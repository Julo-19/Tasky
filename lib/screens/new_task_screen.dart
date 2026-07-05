import 'package:flutter/material.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/priority_selector.widget.dart';
import 'package:tasky/widgets/date_time_selector.widget.dart';
import 'package:tasky/widgets/category_selector.widget.dart';
import 'package:tasky/widgets/button.widget.dart';
import 'package:tasky/controllers/task_controller.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  final TaskController _taskController = TaskController();
  //stoke
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedPriority = 'Moyenne';

  @override
  Future<void> _createTask() async {

  // Validation title required 
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        //message temporaire
        SnackBar(content: Text('Le titre est obligatoire')),
      );
      return;
    }

    try {
      await _taskController.addTask(
        title: _titleController.text,
        content: _contentController.text,
        priority: _selectedPriority,
        color: 'red',
        dueDate: DateTime.now(),
      );

      // Succès redirige home
      if (mounted) {
        Navigator.pop(context);
      }
      } catch (e) {
        // Erreur (show message)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de la création')),
          );
        }
      }
}

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Header
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, size: 24),
                    ),
                  ),
                  Text(
                    'Nouvelle tâche',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              AppTextField(
                label: 'Titre',
                hintText: 'Ex. Créer maquette Figma',
                controller: _titleController,
              ),
              SizedBox(height: 24),
              AppTextField(
                label: 'Description',
                hintText: 'Ajouter des détails...',
                controller: _contentController,
                maxLines: 4,
              ),
              SizedBox(height: 24),
              Text(
                'Priorité',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              PrioritySelector(
                onChanged: (priority) {
                  _selectedPriority = priority;
                },
              ),
              SizedBox(height: 24),
              DateTimeSelector(),
              SizedBox(height: 24),
              Text(
                'Catégorie',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              CategorySelector(),
              SizedBox(height: 60),
              AppButton(
                label: 'Créer la tâche',
                onTap: _createTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}