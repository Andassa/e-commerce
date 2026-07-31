import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shop_hub/data/product_exceptions.dart';
import 'package:shop_hub/data/product_repository.dart';

void main() {
  group('ProductRepository', () {
    test('getProductById parses JSON', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/products/1');
        return http.Response(
          '{"id":1,"title":"Bag","price":9.99,"description":"d",'
          '"category":"c","image":"i","rating":{"rate":4.5,"count":12}}',
          200,
        );
      });
      final repo = ProductRepository(client: client);
      final product = await repo.getProductById(1);
      expect(product.id, 1);
      expect(product.title, 'Bag');
      expect(product.price, 9.99);
      expect(product.rating, 4.5);
    });

    test('non-200 throws ApiException', () async {
      final client = MockClient((_) async => http.Response('nope', 500));
      final repo = ProductRepository(client: client);
      expect(
        () => repo.getAllProducts(),
        throwsA(isA<ApiException>()),
      );
    });

    test('transport failure throws NetworkException', () async {
      final client = MockClient((_) async {
        throw Exception('socket');
      });
      final repo = ProductRepository(client: client);
      expect(
        () => repo.getCategories(),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
