import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/filtered_products_provider.dart';
import '../providers/product_providers.dart';
import '../providers/search_query_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/loading_error_view.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_row.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final async = ref.watch(filteredProductsProvider);
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            SearchBarRow(
              controller: _controller,
              query: query,
              onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
              onClear: () {
                _controller.clear();
                ref.read(searchQueryProvider.notifier).state = '';
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Results for “ $query ”',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  async.maybeWhen(
                    data: (list) => Text(
                      '${list.length} Results Found',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LoadingErrorView<List<Product>>(
                value: async,
                onRetry: () => ref.invalidate(productsProvider),
                builder: (products) {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, i) =>
                        ProductCard(product: products[i], showAdd: true),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
