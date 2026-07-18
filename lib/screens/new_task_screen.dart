import 'package:flutter/material.dart';
import 'package:tasky/controllers/task_controller.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/priority_selector.widget.dart';
import 'package:tasky/widgets/date_time_selector.widget.dart';
import 'package:tasky/widgets/category_selector.widget.dart';
import 'package:tasky/widgets/button.widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskController _taskController = TaskController();
  // Stockage
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedPriority = 'Moyenne';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0);

  Future<void> _createTask() async {
    // Validation : titre obligatoire
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
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
        dueDate: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
      );

      // Succès redirige Home
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Tâche créée avec succès !'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      // Error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la création')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
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
              DateTimeSelector(
                onDateChanged: (date) {
                  _selectedDate = date;
                },
                onTimeChanged: (time) {
                  _selectedTime = time;
                },
              ),
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
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}