import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/cart_provider.dart';
import '../providers/payment_method_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_back_button.dart';
import '../widgets/checkout_info_row.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/primary_button.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final method = ref.watch(paymentMethodProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: const Text('Check Out'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const CheckoutInfoRow(
            icon: Icons.location_on_outlined,
            title: '325 15th Eighth Avenue, NewYork',
            subtitle: 'Saepe eaque fugiat ea voluptatum veniam.',
          ),
          const SizedBox(height: 16),
          const CheckoutInfoRow(
            icon: Icons.access_time,
            title: '6:00 pm, Wednesday 20',
          ),
          const SizedBox(height: 20),
          const OrderSummaryCard(),
          const SizedBox(height: 24),
          const Text(
            'Choose payment method',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          PaymentTile(
            label: 'Paypal',
            icon: Icons.account_balance_wallet_outlined,
            selected: method == PaymentMethod.paypal,
            onTap: () => ref.read(paymentMethodProvider.notifier).state =
                PaymentMethod.paypal,
          ),
          PaymentTile(
            label: 'Credit Card',
            icon: Icons.credit_card,
            selected: method == PaymentMethod.creditCard,
            onTap: () => ref.read(paymentMethodProvider.notifier).state =
                PaymentMethod.creditCard,
          ),
          PaymentTile(
            label: 'Cash',
            icon: Icons.monetization_on_outlined,
            selected: method == PaymentMethod.cash,
            onTap: () =>
                ref.read(paymentMethodProvider.notifier).state = PaymentMethod.cash,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Add new payment method'),
            trailing: const CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.soft,
              child: Icon(Icons.add, size: 16, color: AppColors.text),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Check Out',
            onPressed: () {
              ref.read(cartProvider.notifier).clearCart();
              context.go('/orders');
            },
          ),
        ],
      ),
    );
  }
}
