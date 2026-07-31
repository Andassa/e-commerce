import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_providers.dart';
import '../widgets/loading_error_view.dart';
import '../widgets/product_detail_body.dart';

/// Product detail — watches [productByIdProvider] as [AsyncValue]<[Product]>.
class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final int productId;

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  String _size = '8';

  void _add(Product product) {
    ref.read(cartProvider.notifier).addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Explicit AsyncValue from FutureProvider.family — loading / error / data.
    final AsyncValue<Product> productAsync =
        ref.watch(productByIdProvider(widget.productId));

    return Scaffold(
      body: LoadingErrorView<Product>(
        value: productAsync,
        onRetry: () => ref.invalidate(productByIdProvider(widget.productId)),
        builder: (product) => ProductDetailBody(
          product: product,
          size: _size,
          onSize: (s) => setState(() => _size = s),
          onBuy: () => _add(product),
          onCart: () => _add(product),
        ),
      ),
    );
  }
}
