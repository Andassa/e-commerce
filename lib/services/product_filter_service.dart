import '../models/product.dart';
import '../models/sort_option.dart';

/// Pure filter/sort helpers — kept out of providers to avoid "fat providers".
///
/// Used by [filteredProductsProvider] to combine:
/// category filter + search query + sort option into one list.
class ProductFilterService {
  const ProductFilterService._();

  /// Applies category, then search, then sort. All steps are optional.
  static List<Product> apply({
    required List<Product> products,
    String? category,
    String searchQuery = '',
    SortOption sort = SortOption.priceAsc,
  }) {
    var result = List<Product>.from(products);
    result = byCategory(result, category);
    result = bySearchQuery(result, searchQuery);
    result = sorted(result, sort);
    return result;
  }

  static List<Product> byCategory(List<Product> products, String? category) {
    if (category == null || category.isEmpty) return products;
    return products.where((p) => p.category == category).toList();
  }

  static List<Product> bySearchQuery(List<Product> products, String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return products;
    return products
        .where(
          (p) =>
              p.title.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q),
        )
        .toList();
  }

  static List<Product> sorted(List<Product> products, SortOption sort) {
    final result = List<Product>.from(products);
    result.sort((a, b) => switch (sort) {
          SortOption.priceAsc => a.price.compareTo(b.price),
          SortOption.priceDesc => b.price.compareTo(a.price),
          SortOption.nameAsc => a.title.compareTo(b.title),
        });
    return result;
  }
}
