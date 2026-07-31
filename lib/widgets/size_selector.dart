import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onSelected,
    this.disabled = const {'40'},
  });

  final List<String> sizes;
  final String? selected;
  final ValueChanged<String> onSelected;
  final Set<String> disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: sizes.map((s) {
        final off = disabled.contains(s);
        final on = selected == s;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: off ? null : () => onSelected(s),
            child: Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: on ? AppColors.text : AppColors.muted.withValues(alpha: 0.4),
                  width: on ? 1.5 : 1,
                ),
              ),
              child: Text(
                s,
                style: TextStyle(
                  color: off ? AppColors.muted : AppColors.text,
                  decoration: off ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
