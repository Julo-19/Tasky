import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeSelector extends StatefulWidget {
  final ValueChanged<DateTime>? onDateChanged;
  final ValueChanged<TimeOfDay>? onTimeChanged;

  const DateTimeSelector({
    super.key,
    this.onDateChanged,
    this.onTimeChanged,
  });

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0);

  // calendrier
  void _pickDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            // Bouton OK
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                child: Text('OK', style: TextStyle(color: Color(0xFFFF6B5C))),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // La roue
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime.now().subtract(Duration(days: 1)),
                maximumDate: DateTime(2030),
                onDateTimeChanged: (DateTime picked) {
                  setState(() {
                    _selectedDate = picked;
                  });
                  widget.onDateChanged?.call(picked);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickTime() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                child: Text('OK', style: TextStyle(color: Color(0xFFFF6B5C))),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: DateTime(
                  2026, 1, 1,
                  _selectedTime.hour,
                  _selectedTime.minute,
                ),
                onDateTimeChanged: (DateTime picked) {
                  setState(() {
                    _selectedTime = TimeOfDay(
                      hour: picked.hour,
                      minute: picked.minute,
                    );
                  });
                  widget.onTimeChanged?.call(_selectedTime);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Formate la date pour l'affichage
  String get _dateLabel {
    final now = DateTime.now();
    if (_selectedDate.day == now.day &&
        _selectedDate.month == now.month &&
        _selectedDate.year == now.year) {
      return 'Aujourd\'hui';
    }
    return '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
  }

  // Formate l'heure pour l'affichage
  String get _timeLabel {
    final hour = _selectedTime.hour.toString().padLeft(2, '0');
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

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
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 18, color: Color(0xFFFF6B5C)),
                      SizedBox(width: 8),
                      Text(
                        _dateLabel,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
                      ),
                    ],
                  ),
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
              GestureDetector(
                onTap: _pickTime,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 18, color: Color(0xFFFF6B5C)),
                      SizedBox(width: 8),
                      Text(
                        _timeLabel,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}