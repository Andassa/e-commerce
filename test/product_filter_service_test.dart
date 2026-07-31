import 'package:flutter_test/flutter_test.dart';
import 'package:shop_hub/models/product.dart';
import 'package:shop_hub/models/sort_option.dart';
import 'package:shop_hub/services/product_filter_service.dart';

Product _p({
  required int id,
  required String title,
  required double price,
  required String category,
}) {
  return Product(
    id: id,
    title: title,
    price: price,
    description: 'desc $title',
    category: category,
    image: 'https://example.com/$id.png',
    rating: 4,
    ratingCount: 10,
  );
}

void main() {
  final catalog = [
    _p(id: 1, title: 'Alpha Shirt', price: 30, category: "men's clothing"),
    _p(id: 2, title: 'Beta Jacket', price: 10, category: "women's clothing"),
    _p(id: 3, title: 'Gamma Ring', price: 20, category: 'jewelery'),
  ];

  group('ProductFilterService', () {
    test('byCategory keeps only matching category', () {
      final result = ProductFilterService.byCategory(catalog, "men's clothing");
      expect(result.map((e) => e.id), [1]);
    });

    test('byCategory with null returns all', () {
      expect(ProductFilterService.byCategory(catalog, null).length, 3);
    });

    test('bySearchQuery matches title', () {
      final result = ProductFilterService.bySearchQuery(catalog, 'jacket');
      expect(result.map((e) => e.id), [2]);
    });

    test('sorted priceAsc', () {
      final result = ProductFilterService.sorted(catalog, SortOption.priceAsc);
      expect(result.map((e) => e.price), [10, 20, 30]);
    });

    test('sorted priceDesc', () {
      final result = ProductFilterService.sorted(catalog, SortOption.priceDesc);
      expect(result.map((e) => e.price), [30, 20, 10]);
    });

    test('sorted nameAsc', () {
      final result = ProductFilterService.sorted(catalog, SortOption.nameAsc);
      expect(result.map((e) => e.title), [
        'Alpha Shirt',
        'Beta Jacket',
        'Gamma Ring',
      ]);
    });

    test('apply combines category + search + sort', () {
      final mixed = [
        ...catalog,
        _p(id: 4, title: 'Men Boots', price: 5, category: "men's clothing"),
      ];
      final result = ProductFilterService.apply(
        products: mixed,
        category: "men's clothing",
        searchQuery: 'men',
        sort: SortOption.priceAsc,
      );
      expect(result.map((e) => e.id), [4, 1]);
    });
  });
}
