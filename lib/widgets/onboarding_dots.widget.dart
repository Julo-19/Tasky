import 'package:flutter/material.dart';

class OnboardingDots extends StatelessWidget {
  final int currentPage;

  const OnboardingDots({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       //dot1
        Container(
          width: currentPage == 0 ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == 0 ? Color(0xFFFF6B5C) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        // dot2
        Container(
          width: currentPage == 1 ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == 1 ? Color(0xFFFF6B5C) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        //  dot3
        Container(
          width: currentPage == 2 ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == 2 ? Color(0xFFFF6B5C) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}