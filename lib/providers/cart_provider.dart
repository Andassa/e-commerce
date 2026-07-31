import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

/// Manages cart items and derived totals.
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(const []);

  void addToCart(Product product) {
    final i = state.indexWhere((e) => e.product.id == product.id);
    if (i >= 0) {
      state = [...state]..[i] = state[i].copyWith(quantity: state[i].quantity + 1);
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeFromCart(int productId) {
    state = state.where((e) => e.product.id != productId).toList();
  }

  void incrementQuantity(int productId) {
    final i = state.indexWhere((e) => e.product.id == productId);
    if (i < 0) return;
    state = [...state]..[i] = state[i].copyWith(quantity: state[i].quantity + 1);
  }

  void decrementQuantity(int productId) {
    final i = state.indexWhere((e) => e.product.id == productId);
    if (i < 0) return;
    if (state[i].quantity <= 1) {
      removeFromCart(productId);
      return;
    }
    state = [...state]..[i] = state[i].copyWith(quantity: state[i].quantity - 1);
  }

  void clearCart() => state = const [];

  double get totalPrice =>
      state.fold(0, (sum, e) => sum + e.lineTotal);

  int get itemCount => state.fold(0, (sum, e) => sum + e.quantity);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
