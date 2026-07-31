import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'circle_icon_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/images/image 1.jpg'),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello!', style: TextStyle(color: AppColors.muted)),
              Text(
                'John William',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ],
          ),
        ),
        CircleIconButton(icon: Icons.notifications_none, onTap: () {}),
      ],
    );
  }
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.soft,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: AppColors.muted),
            SizedBox(width: 8),
            Text('Search here', style: TextStyle(color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}
