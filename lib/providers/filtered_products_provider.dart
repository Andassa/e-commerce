import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../services/product_filter_service.dart';
import 'category_filter_provider.dart';
import 'product_providers.dart';
import 'search_query_provider.dart';
import 'sort_option_provider.dart';

/// Combines catalog [AsyncValue] with all filter/sort providers.
///
/// Watches:
/// - [productsProvider] — async product list
/// - [categoryFilterProvider] — selected category (`null` = all)
/// - [searchQueryProvider] — free-text search
/// - [sortOptionProvider] — price / name sort
///
/// Returns [AsyncValue] so UI can show loading / error / data via `.when`.
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final category = ref.watch(categoryFilterProvider);
  final sort = ref.watch(sortOptionProvider);
  final query = ref.watch(searchQueryProvider);

  return productsAsync.whenData(
    (products) => ProductFilterService.apply(
      products: products,
      category: category,
      searchQuery: query,
      sort: sort,
    ),
  );
});

/// Convenience: current filter snapshot for debugging / UI chips.
final activeFiltersSummaryProvider = Provider<String>((ref) {
  final category = ref.watch(categoryFilterProvider);
  final sort = ref.watch(sortOptionProvider);
  final query = ref.watch(searchQueryProvider).trim();
  final parts = <String>[
    if (category != null) 'category=$category',
    if (query.isNotEmpty) 'q=$query',
    'sort=${sort.name}',
  ];
  return parts.join(' · ');
});
