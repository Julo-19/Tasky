import 'package:flutter/material.dart';
import 'package:tasky/widgets/stat_card.widget.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String initials;
  final String completedCount;
  final String inProgressCount;
  final String regularity;
  final VoidCallback onEditTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.initials,
    required this.completedCount,
    required this.inProgressCount,
    required this.regularity,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 60, 24, 24),
      decoration: BoxDecoration(
        color: Color(0xFFFF6B5C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onEditTap,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.edit_outlined, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: StatCard(value: completedCount, label: 'Total')),
              SizedBox(width: 8),
              Expanded(child: StatCard(value: inProgressCount, label: 'Aujourd\'hui')),
              SizedBox(width: 8),
              Expanded(child: StatCard(value: regularity, label: 'À venir')),
            ],
          ),
        ],
      ),
    );
  }
}