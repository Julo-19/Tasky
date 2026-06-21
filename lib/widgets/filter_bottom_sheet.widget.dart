import 'package:flutter/material.dart';
import 'package:tasky/widgets/button.widget.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtres & tri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Réinitialiser',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF6B5C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildPriorityOption('Priorité Haute', Colors.red),
          SizedBox(height: 12),
          _buildPriorityOption('Priorité Moyenne', Colors.orange),
          SizedBox(height: 12),
          _buildPriorityOption('Priorité Basse', Colors.green),
          SizedBox(height: 24),
          Text(
            'TRIER PAR',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: ['Date', 'Priorité', 'A → Z'].map((sort) {
              bool isSelected = sort == 'Date';

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: sort != 'A → Z' ? 8 : 0),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFFFF6B5C) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    sort,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24),
          AppButton(
            label: 'Appliquer les filtres',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityOption(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.flag, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          Icon(Icons.circle_outlined, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}