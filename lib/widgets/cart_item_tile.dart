import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import 'circle_icon_button.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({super.key, required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider.notifier);
    final p = item.product;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ColoredBox(
              color: AppColors.soft,
              child: CachedNetworkImage(
                imageUrl: p.image,
                width: 72,
                height: 72,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => cart.removeFromCart(p.id),
                      child: const Icon(Icons.delete_outline,
                          color: AppColors.danger, size: 20),
                    ),
                  ],
                ),
                Text(p.category,
                    style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${p.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    CircleIconButton(
                      icon: Icons.remove,
                      onTap: () => cart.decrementQuantity(p.id),
                      bg: AppColors.accent,
                      color: Colors.white,
                      size: 28,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        item.quantity.toString().padLeft(2, '0'),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    CircleIconButton(
                      icon: Icons.add,
                      onTap: () => cart.incrementQuantity(p.id),
                      bg: AppColors.accent,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
