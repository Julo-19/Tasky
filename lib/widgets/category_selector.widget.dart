import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final String initialCategory;

  const CategorySelector({
    super.key,
    this.initialCategory = 'Travail',
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  late String _selectedCategory;
  final List<String> _categories = ['Travail', 'Études', 'Personnel'];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _categories.map((category) {
        bool isSelected = category == _selectedCategory;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: category != _categories.last ? 8 : 0),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFFFF6B5C).withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Color(0xFFFF6B5C) : Colors.grey.shade300,
                ),
              ),
              child: Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Color(0xFFFF6B5C) : Colors.grey,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}