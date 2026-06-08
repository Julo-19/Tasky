import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFFECEA),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Image.asset(image),
          ),
        ),
        const SizedBox(height: 32),
        // Titre
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}