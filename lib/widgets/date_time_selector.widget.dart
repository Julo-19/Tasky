import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {
  final String date;
  final String time;

  const DateTimeSelector({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFFFF6B5C)),
                    SizedBox(width: 8),
                    Text(
                      date,
                      style: TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        // Heure
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Heure',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 18, color: Color(0xFFFF6B5C)),
                    SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}