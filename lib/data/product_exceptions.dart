/// Base type for catalog / network failures surfaced via [AsyncValue.error].
sealed class ProductException implements Exception {
  const ProductException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Device offline or DNS / socket failure before an HTTP response.
class NetworkException extends ProductException {
  const NetworkException([
    super.message = 'No connection. Check your network.',
  ]);
}

/// Non-success HTTP status from FakeStoreAPI.
class ApiException extends ProductException {
  const ApiException(this.statusCode, [String? message])
      : super(message ?? 'Failed to load products ($statusCode)');

  final int statusCode;
}

/// JSON shape unexpected or missing required fields.
class ParseException extends ProductException {
  const ParseException([super.message = 'Invalid product data from API.']);
}
