import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import 'product_exceptions.dart';

/// Fetches catalog data from FakeStoreAPI.
/// Inject [client] in tests to avoid real network calls.
class ProductRepository {
  ProductRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _base = 'https://fakestoreapi.com';

  Future<List<Product>> getAllProducts() async {
    final body = await _get('/products');
    try {
      final list = jsonDecode(body) as List<dynamic>;
      return list
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } on FormatException catch (e) {
      throw ParseException(e.message);
    } on TypeError {
      throw const ParseException();
    }
  }

  Future<List<String>> getCategories() async {
    final body = await _get('/products/categories');
    try {
      return (jsonDecode(body) as List<dynamic>).cast<String>();
    } on FormatException catch (e) {
      throw ParseException(e.message);
    } on TypeError {
      throw const ParseException();
    }
  }

  Future<Product> getProductById(int id) async {
    final body = await _get('/products/$id');
    try {
      return Product.fromJson(jsonDecode(body) as Map<String, dynamic>);
    } on FormatException catch (e) {
      throw ParseException(e.message);
    } on TypeError {
      throw const ParseException();
    }
  }

  /// GET [path] relative to FakeStoreAPI base URL.
  /// Maps HTTP failures to [ApiException] and transport issues to [NetworkException].
  Future<String> _get(String path) async {
    try {
      final res = await _client.get(Uri.parse('$_base$path'));
      if (res.statusCode != 200) {
        throw ApiException(res.statusCode);
      }
      return res.body;
    } on ProductException {
      rethrow;
    } catch (_) {
      throw const NetworkException();
    }
  }
}
