import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import 'circle_icon_button.dart';

class ProductDetailHero extends ConsumerWidget {
  const ProductDetailHero({super.key, required this.imageUrl, required this.productId});

  final String imageUrl;
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fav = ref.watch(favoritesProvider).contains(productId);
    final top = MediaQuery.paddingOf(context).top + 8;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
          child: ColoredBox(
            color: AppColors.soft,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: MediaQuery.sizeOf(context).height * 0.42,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: top,
          left: 16,
          child: CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: top,
          right: 16,
          child: CircleIconButton(
            icon: fav ? Icons.favorite : Icons.favorite_border,
            color: fav ? Colors.red : AppColors.muted,
            onTap: () =>
                ref.read(favoritesProvider.notifier).toggleFavorite(productId),
          ),
        ),
      ],
    );
  }
}
