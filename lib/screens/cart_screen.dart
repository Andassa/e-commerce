import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/cart_provider.dart';
import '../widgets/app_back_button.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/primary_button.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        leading: showBack
            ? const Padding(
                padding: EdgeInsets.only(left: 12),
                child: AppBackButton(),
              )
            : null,
        title: const Text('Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleIconButton(icon: Icons.more_vert, onTap: () {}),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                ...items.map((e) => CartItemTile(item: e)),
                const SizedBox(height: 8),
                const OrderSummaryCard(),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: 'Check Out',
                  onPressed: () => context.push('/checkout'),
                ),
              ],
            ),
    );
  }
}
