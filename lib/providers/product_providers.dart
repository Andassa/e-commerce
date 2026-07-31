import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../models/product.dart';

/// Injectable repository — override in tests with a fake / mock client.
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

/// Full catalog as [AsyncValue] via [FutureProvider].
final productsProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getAllProducts();
});

/// Category names as [AsyncValue].
final categoriesProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(productRepositoryProvider).getCategories();
});

/// Single product by id as [AsyncValue] — UI must handle loading / error / data
/// (see [ProductDetailScreen] + [LoadingErrorView]).
final productByIdProvider = FutureProvider.family<Product, int>((ref, id) {
  return ref.watch(productRepositoryProvider).getProductById(id);
});
