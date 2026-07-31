import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/product_providers.dart';
import '../theme/app_colors.dart';
import '../widgets/app_back_button.dart';
import '../widgets/loading_error_view.dart';
import '../widgets/order_tile.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: const Text('Orders'),
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.text,
          unselectedLabelColor: AppColors.muted,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancel'),
          ],
        ),
      ),
      body: LoadingErrorView(
        value: ref.watch(productsProvider),
        onRetry: () => ref.invalidate(productsProvider),
        builder: (data) {
          final products = (data as List<Product>).take(3).toList();
          return TabBarView(
            controller: _tabs,
            children: [
              ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: products.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, i) => OrderTile(product: products[i]),
              ),
              const Center(child: Text('No completed orders')),
              const Center(child: Text('No cancelled orders')),
            ],
          );
        },
      ),
    );
  }
}
