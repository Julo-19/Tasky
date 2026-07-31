import 'package:flutter/material.dart';

class PriorityFilter extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const PriorityFilter({super.key, this.onChanged});

  @override
  State<PriorityFilter> createState() => _PriorityFilterState();
}

class _PriorityFilterState extends State<PriorityFilter> {
  int _selectedIndex = 0;
  final List<String> _priorities = ['Toutes', 'Haute', 'Moyenne', 'Basse'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _priorities.map((priority) {
        int index = _priorities.indexOf(priority);
        bool isSelected = index == _selectedIndex;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            widget.onChanged?.call(priority);
          },
          child: Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFFF6B5C) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Color(0xFFFF6B5C) : Colors.grey.shade300,
              ),
            ),
            child: Text(
              priority,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}