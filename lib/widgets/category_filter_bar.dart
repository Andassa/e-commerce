import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/category_filter_provider.dart';
import '../providers/product_providers.dart';
import '../theme/app_colors.dart';
import 'loading_error_view.dart';

class CategoryFilterBar extends ConsumerWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(categoryFilterProvider);
    return SizedBox(
      height: 40,
      child: LoadingErrorView<List<String>>(
        value: ref.watch(categoriesProvider),
        onRetry: () => ref.invalidate(categoriesProvider),
        builder: (cats) {
          final items = <String?>[null, ...cats];
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final cat = items[i];
              final active = selected == cat;
              return ChoiceChip(
                label: Text(cat ?? 'All'),
                selected: active,
                onSelected: (_) =>
                    ref.read(categoryFilterProvider.notifier).state = cat,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: active ? Colors.white : AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: AppColors.soft,
                showCheckmark: false,
              );
            },
          );
        },
      ),
    );
  }
}
