import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../models/sort_option.dart';
import 'category_filter_provider.dart';
import 'product_providers.dart';
import 'search_query_provider.dart';
import 'sort_option_provider.dart';

final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final products = ref.watch(productsProvider);
  final category = ref.watch(categoryFilterProvider);
  final sort = ref.watch(sortOptionProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();

  return products.whenData((list) {
    var result = list.toList();
    if (category != null) {
      result = result.where((p) => p.category == category).toList();
    }
    if (query.isNotEmpty) {
      result = result.where((p) => p.title.toLowerCase().contains(query)).toList();
    }
    result.sort((a, b) => switch (sort) {
          SortOption.priceAsc => a.price.compareTo(b.price),
          SortOption.priceDesc => b.price.compareTo(a.price),
          SortOption.nameAsc => a.title.compareTo(b.title),
        });
    return result;
  });
});
