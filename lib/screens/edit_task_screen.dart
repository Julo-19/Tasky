import 'package:flutter/material.dart';
import 'package:tasky/controllers/task_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/priority_selector.widget.dart';
import 'package:tasky/widgets/date_time_selector.widget.dart';
import 'package:tasky/widgets/category_selector.widget.dart';
import 'package:tasky/widgets/button.widget.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TaskController _taskController = TaskController();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _selectedPriority;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    // Pré-remplissage avec les valeurs de la tâche reçue
    _titleController = TextEditingController(text: widget.task.title);
    _contentController = TextEditingController(text: widget.task.content);
    _selectedPriority = widget.task.priority;
    final due = widget.task.dueDate?.toLocal() ?? DateTime.now();
    _selectedDate = due;
    _selectedTime = TimeOfDay(hour: due.hour, minute: due.minute);
  }

  Future<void> _updateTask() async {
    // Validation : titre obligatoire
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Le titre est obligatoire')),
      );
      return;
    }

    try {
      await _taskController.editTask(
        id: widget.task.id!,
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

      // Succès → message + retour à la Home
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Tâche modifiée avec succès !'),
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la modification')),
        );
      }
    }
  }

  Future<void> _deleteTask() async {
    // Demande de confirmation
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer la tâche ?'),
        content: Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    // Si l'utilisateur annule, on arrête
    if (confirm != true) return;

    try {
      await _taskController.removeTask(widget.task.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Tâche supprimée !'),
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression')),
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
                    'Modifier tâche',
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
                maxLines: 4,
                controller: _contentController,
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
              SizedBox(height: 32),
              AppButton(
                label: 'Enregistrer',
                onTap: _updateTask,
              ),
              SizedBox(height: 12),
              // Bouton Supprimer
              GestureDetector(
                onTap: _deleteTask,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Supprimer la tâche',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}