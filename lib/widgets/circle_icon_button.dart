import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.bg = AppColors.soft,
    this.color = AppColors.text,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color bg;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
}
