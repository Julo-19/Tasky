import 'package:flutter/material.dart';

class HomeFilter extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const HomeFilter({super.key, this.onChanged});

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  int _selectedIndex = 0;
  final List<String> _filters = ['Aujourd\'hui', 'À venir', 'Terminées'];

 @override
Widget build(BuildContext context) {
  return Row(
    children: _filters.map((filter) {
      int index = _filters.indexOf(filter);
      bool isSelected = index == _selectedIndex;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          widget.onChanged?.call(filter);
        },
        child: Container(
          margin: EdgeInsets.only(right: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFFF6B5C) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Color(0xFFFF6B5C) : Colors.grey.shade300,
            ),
          ),
          child: Text(
            filter,
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