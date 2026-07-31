import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../providers/filtered_products_provider.dart';
import '../providers/product_providers.dart';
import '../widgets/home_header.dart';
import '../widgets/loading_error_view.dart';
import '../widgets/product_h_list.dart';
import '../widgets/promo_banner.dart';
import '../widgets/section_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: LoadingErrorView<List<Product>>(
          value: ref.watch(filteredProductsProvider),
          onRetry: () => ref.invalidate(productsProvider),
          builder: (products) {
            final featured = products.take(6).toList();
            final popular = products.length > 6
                ? products.skip(6).take(6).toList()
                : featured.reversed.toList();
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(productsProvider),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 18),
                  HomeSearchField(onTap: () => context.go('/search')),
                  const SizedBox(height: 18),
                  const PromoBanner(),
                  const SizedBox(height: 20),
                  SectionHeader(
                    title: 'Featured',
                    action: 'See All',
                    onAction: () => context.push('/products'),
                  ),
                  const SizedBox(height: 12),
                  ProductHList(products: featured),
                  const SizedBox(height: 20),
                  SectionHeader(
                    title: 'Most Popular',
                    action: 'See All',
                    onAction: () => context.push('/products'),
                  ),
                  const SizedBox(height: 12),
                  ProductHList(products: popular),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
