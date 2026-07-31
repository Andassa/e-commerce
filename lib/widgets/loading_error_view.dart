import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_colors.dart';

/// Renders [AsyncValue] with explicit loading / error / data branches.
///
/// Used for [productsProvider], [filteredProductsProvider], [productByIdProvider],
/// and [categoriesProvider] so every async screen handles [AsyncValue] consistently.
class LoadingErrorView<T> extends StatelessWidget {
  const LoadingErrorView({
    super.key,
    required this.value,
    required this.onRetry,
    required this.builder,
  });

  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: builder,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 40, color: AppColors.muted),
              const SizedBox(height: 12),
              Text(
                '$err',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.text),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
