import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';

class OrderSummaryCard extends ConsumerWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final subtotal = cart.fold(0.0, (s, e) => s + e.lineTotal);
    const discount = 4.0;
    const delivery = 2.0;
    final total = (subtotal - discount + delivery).clamp(0, double.infinity);

    Widget row(String label, String value, {bool bold = false}) {
      final style = TextStyle(
        fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
        fontSize: bold ? 16 : 14,
      );
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(label, style: style),
            const Spacer(),
            Text(value, style: style),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          row('Items', '${cart.length}'),
          row('Subtotal', '\$${subtotal.toStringAsFixed(0)}'),
          row('Discount', '\$${discount.toStringAsFixed(0)}'),
          row('Delivery Charges', '\$${delivery.toStringAsFixed(0)}'),
          const Divider(height: 20),
          row('Total', '\$${total.toStringAsFixed(0)}', bold: true),
        ],
      ),
    );
  }
}
