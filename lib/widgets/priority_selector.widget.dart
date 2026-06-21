import 'package:flutter/material.dart';

class PrioritySelector extends StatefulWidget {
  const PrioritySelector({super.key});

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  int _selectedIndex = 1; // Moyenne sélectionnée par défaut

 @override
Widget build(BuildContext context) {
  final priorities = [
    {'label': 'Haute', 'color': Colors.red},
    {'label': 'Moyenne', 'color': Colors.orange},
    {'label': 'Basse', 'color': Colors.green},
  ];

  return Row(
    children: priorities.map((priority) {
      int index = priorities.indexOf(priority);
      bool isSelected = index == _selectedIndex;
      Color color = priority['color'] as Color;

      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? color : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  priority['label'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}
}