import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/filter_ui_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_back_button.dart';
import '../widgets/filter_chips.dart';
import '../widgets/primary_button.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(filterGenderProvider);
    final brands = ref.watch(filterBrandsProvider);
    final colors = ref.watch(filterColorsProvider);
    final range = ref.watch(filterPriceRangeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: const Text('Filter'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text('Gender', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),
          FilterChips(
            options: const ['All', 'Men', 'Women'],
            selected: {gender},
            onTap: (v) => ref.read(filterGenderProvider.notifier).state = v,
          ),
          const SizedBox(height: 20),
          const Text('Brand', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),
          FilterChips(
            options: const ['Adidas', 'Puma', 'CR7', 'Nike', 'Yeezy', 'Supreme'],
            selected: brands,
            onTap: (v) {
              final next = {...brands};
              next.contains(v) ? next.remove(v) : next.add(v);
              ref.read(filterBrandsProvider.notifier).state = next;
            },
          ),
          const SizedBox(height: 20),
          const Text('Price Range',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          Row(
            children: [
              Text('\$${range.start.round()}'),
              const Spacer(),
              Text('\$${range.end.round()}'),
            ],
          ),
          RangeSlider(
            values: range,
            min: 16,
            max: 543,
            activeColor: AppColors.primary,
            onChanged: (v) =>
                ref.read(filterPriceRangeProvider.notifier).state = v,
          ),
          const Text('Color', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),
          FilterChips(
            options: const ['White', 'Black', 'Grey', 'Yellow', 'Red', 'Green'],
            selected: colors,
            onTap: (v) {
              final next = {...colors};
              next.contains(v) ? next.remove(v) : next.add(v);
              ref.read(filterColorsProvider.notifier).state = next;
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.soft,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Text('Another option', style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Icon(Icons.chevron_right, color: AppColors.muted),
              ],
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(label: 'Apply Filter', onPressed: () => context.pop()),
        ],
      ),
    );
  }
}
