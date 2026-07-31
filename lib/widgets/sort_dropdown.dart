import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sort_option.dart';
import '../providers/sort_option_provider.dart';
import '../theme/app_colors.dart';

class SortDropdown extends ConsumerWidget {
  const SortDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortOptionProvider);
    return DropdownButtonHideUnderline(
      child: DropdownButton<SortOption>(
        value: sort,
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.muted),
        style: const TextStyle(color: AppColors.text, fontSize: 13),
        items: SortOption.values
            .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
            .toList(),
        onChanged: (v) {
          if (v != null) ref.read(sortOptionProvider.notifier).state = v;
        },
      ),
    );
  }
}
