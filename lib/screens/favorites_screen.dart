import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/favorites_provider.dart';
import '../providers/product_providers.dart';
import '../widgets/app_back_button.dart';
import '../widgets/loading_error_view.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIds = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: const Text('Favorites'),
      ),
      body: LoadingErrorView(
        value: ref.watch(productsProvider),
        onRetry: () => ref.invalidate(productsProvider),
        builder: (data) {
          final products =
              (data as List<Product>).where((p) => favIds.contains(p.id)).toList();
          if (products.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemCount: products.length,
            itemBuilder: (_, i) => ProductCard(product: products[i], showAdd: true),
          );
        },
      ),
    );
  }
}
