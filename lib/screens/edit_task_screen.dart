import 'package:flutter/material.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/priority_selector.widget.dart';
import 'package:tasky/widgets/date_time_selector.widget.dart';
import 'package:tasky/widgets/category_selector.widget.dart';
import 'package:tasky/widgets/button.widget.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
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
              ),
              SizedBox(height: 24),
              AppTextField(
                label: 'Description',
                hintText: 'Ajouter des détails...',
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
              PrioritySelector(),
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
              SizedBox(height: 32),
              AppButton(
                label: 'Enregistrer',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}