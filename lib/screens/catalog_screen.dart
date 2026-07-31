import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/filtered_products_provider.dart';
import '../providers/product_providers.dart';
import '../widgets/app_back_button.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/loading_error_view.dart';
import '../widgets/product_card.dart';
import '../widgets/sort_dropdown.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: CategoryFilterBar(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: SortDropdown(),
            ),
          ),
          Expanded(
            child: LoadingErrorView<List<Product>>(
              value: ref.watch(filteredProductsProvider),
              onRetry: () => ref.invalidate(productsProvider),
              builder: (products) {
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(productsProvider),
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (_, i) => ProductCard(
                      product: products[i],
                      showAdd: true,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
