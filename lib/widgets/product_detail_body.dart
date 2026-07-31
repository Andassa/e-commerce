import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';
import 'circle_icon_button.dart';
import 'primary_button.dart';
import 'product_detail_hero.dart';
import 'size_selector.dart';

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({
    super.key,
    required this.product,
    required this.size,
    required this.onSize,
    required this.onBuy,
    required this.onCart,
  });

  final Product product;
  final String size;
  final ValueChanged<String> onSize;
  final VoidCallback onBuy;
  final VoidCallback onCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ProductDetailHero(imageUrl: product.image, productId: product.id),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(' ${product.rating}',
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                        Text(' ( ${product.ratingCount} Review)',
                            style: const TextStyle(color: AppColors.muted)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text('Description',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(product.description,
                        style: const TextStyle(color: AppColors.muted, height: 1.4)),
                    const SizedBox(height: 18),
                    const Text('Size',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 10),
                    SizeSelector(
                      sizes: const ['8', '10', '38', '40'],
                      selected: size,
                      onSelected: onSize,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Row(
            children: [
              Expanded(child: PrimaryButton(label: 'Buy Now', onPressed: onBuy)),
              const SizedBox(width: 12),
              CircleIconButton(
                icon: Icons.shopping_bag_outlined,
                size: 54,
                onTap: onCart,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
