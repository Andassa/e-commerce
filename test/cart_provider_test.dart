import 'package:flutter_test/flutter_test.dart';
import 'package:shop_hub/models/product.dart';
import 'package:shop_hub/providers/cart_provider.dart';

Product _product(int id, {double price = 10}) {
  return Product(
    id: id,
    title: 'P$id',
    price: price,
    description: 'd',
    category: 'c',
    image: 'i',
    rating: 4,
    ratingCount: 1,
  );
}

void main() {
  group('CartNotifier', () {
    late CartNotifier cart;

    setUp(() => cart = CartNotifier());

    test('starts empty', () {
      expect(cart.state, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.totalPrice, 0);
    });

    test('addToCart adds then increments quantity immutably', () {
      final p = _product(1, price: 12);
      cart.addToCart(p);
      expect(cart.state.length, 1);
      expect(cart.state.first.quantity, 1);

      final before = cart.state;
      cart.addToCart(p);
      expect(identical(before, cart.state), isFalse);
      expect(cart.state.first.quantity, 2);
      expect(cart.itemCount, 2);
      expect(cart.totalPrice, 24);
    });

    test('decrementQuantity removes at 1', () {
      cart.addToCart(_product(2));
      cart.decrementQuantity(2);
      expect(cart.state, isEmpty);
    });

    test('removeFromCart and clearCart', () {
      cart.addToCart(_product(1));
      cart.addToCart(_product(2));
      cart.removeFromCart(1);
      expect(cart.state.map((e) => e.product.id), [2]);
      cart.clearCart();
      expect(cart.state, isEmpty);
    });
  });
}
