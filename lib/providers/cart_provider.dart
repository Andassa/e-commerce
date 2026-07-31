import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

/// Manages cart items with immutable state updates (new list on every change).
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(const []);

  void addToCart(Product product) {
    final i = state.indexWhere((e) => e.product.id == product.id);
    if (i >= 0) {
      final updated = state[i].copyWith(quantity: state[i].quantity + 1);
      state = [
        for (var j = 0; j < state.length; j++)
          if (j == i) updated else state[j],
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeFromCart(int productId) {
    state = [
      for (final item in state)
        if (item.product.id != productId) item,
    ];
  }

  void incrementQuantity(int productId) {
    final i = state.indexWhere((e) => e.product.id == productId);
    if (i < 0) return;
    final updated = state[i].copyWith(quantity: state[i].quantity + 1);
    state = [
      for (var j = 0; j < state.length; j++)
        if (j == i) updated else state[j],
    ];
  }

  void decrementQuantity(int productId) {
    final i = state.indexWhere((e) => e.product.id == productId);
    if (i < 0) return;
    if (state[i].quantity <= 1) {
      removeFromCart(productId);
      return;
    }
    final updated = state[i].copyWith(quantity: state[i].quantity - 1);
    state = [
      for (var j = 0; j < state.length; j++)
        if (j == i) updated else state[j],
    ];
  }

  void clearCart() => state = const [];

  double get totalPrice => state.fold(0, (sum, e) => sum + e.lineTotal);

  int get itemCount => state.fold(0, (sum, e) => sum + e.quantity);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
