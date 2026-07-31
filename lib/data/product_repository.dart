import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductFetchException implements Exception {
  ProductFetchException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Fetches catalog data from FakeStoreAPI. Swap [client] or override methods for local JSON.
class ProductRepository {
  ProductRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _base = 'https://fakestoreapi.com';

  Future<List<Product>> getAllProducts() async {
    final res = await _get('/products');
    final list = jsonDecode(res) as List<dynamic>;
    return list.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<String>> getCategories() async {
    final res = await _get('/products/categories');
    return (jsonDecode(res) as List<dynamic>).cast<String>();
  }

  Future<Product> getProductById(int id) async {
    final res = await _get('/products/$id');
    return Product.fromJson(jsonDecode(res) as Map<String, dynamic>);
  }

  Future<String> _get(String path) async {
    try {
      final res = await _client.get(Uri.parse('$_base$path'));
      if (res.statusCode != 200) {
        throw ProductFetchException('Failed to load products (${res.statusCode})');
      }
      return res.body;
    } catch (e) {
      if (e is ProductFetchException) rethrow;
      throw ProductFetchException('No connection. Check your network.');
    }
  }
}
