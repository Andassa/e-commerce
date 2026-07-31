import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/favorites_local_datasource.dart';

final favoritesLocalDatasourceProvider = Provider((ref) {
  return FavoritesLocalDatasource();
});

/// Persists favorite product IDs via shared_preferences.
class FavoritesNotifier extends StateNotifier<Set<int>> {
  FavoritesNotifier(this._ds) : super({}) {
    _load();
  }

  final FavoritesLocalDatasource _ds;

  Future<void> _load() async {
    state = await _ds.load();
  }

  Future<void> toggleFavorite(int id) async {
    final next = {...state};
    next.contains(id) ? next.remove(id) : next.add(id);
    state = next;
    await _ds.save(state);
  }

  bool isFavorite(int id) => state.contains(id);
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<int>>((ref) {
  return FavoritesNotifier(ref.watch(favoritesLocalDatasourceProvider));
});
