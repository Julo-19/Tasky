import 'package:flutter/material.dart';
import 'package:tasky/widgets/profile_menu_item.widget.dart';

class ProfileMenuSection extends StatelessWidget {
  final List<ProfileMenuItem> items;

  const ProfileMenuSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          return Column(
            children: [
              items[index],
              if (index != items.length - 1)
                Divider(height: 1, color: Colors.grey.shade200),
            ],
          );
        }),
      ),
    );
  }
}