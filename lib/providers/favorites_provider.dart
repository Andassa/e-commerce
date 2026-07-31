import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/favorites_local_datasource.dart';

final favoritesLocalDatasourceProvider = Provider<FavoritesLocalDatasource>((ref) {
  return FavoritesLocalDatasource();
});

/// Loads favorites from [FavoritesLocalDatasource] on init,
/// and saves after every mutation — local persistence is always wired.
class FavoritesNotifier extends StateNotifier<Set<int>> {
  FavoritesNotifier(this._datasource) : super(const <int>{}) {
    loadFromLocalStorage();
  }

  final FavoritesLocalDatasource _datasource;

  /// Hydrate state from shared_preferences.
  Future<void> loadFromLocalStorage() async {
    final ids = await _datasource.load();
    state = Set<int>.unmodifiable(ids);
  }

  /// Toggle favorite and persist the new set locally.
  Future<void> toggleFavorite(int productId) async {
    final next = Set<int>.from(state);
    if (next.contains(productId)) {
      next.remove(productId);
    } else {
      next.add(productId);
    }
    state = Set<int>.unmodifiable(next);
    await _datasource.save(next);
  }

  bool isFavorite(int productId) => state.contains(productId);

  Future<void> clearFavorites() async {
    state = const <int>{};
    await _datasource.clear();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<int>>((ref) {
  return FavoritesNotifier(ref.watch(favoritesLocalDatasourceProvider));
});
