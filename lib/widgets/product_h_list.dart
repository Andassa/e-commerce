import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_card.dart';

class ProductHList extends StatelessWidget {
  const ProductHList({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, i) => ProductCard(product: products[i], width: 130),
      ),
    );
  }
}
