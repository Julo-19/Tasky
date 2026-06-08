import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText, 
            prefixIcon: Icon(prefixIcon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}