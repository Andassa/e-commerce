import 'package:shared_preferences/shared_preferences.dart';

/// Local persistence for favorite product IDs (shared_preferences).
///
/// Requirement: "System of favorites persisted locally".
class FavoritesLocalDatasource {
  FavoritesLocalDatasource({this._prefs});

  static const _key = 'favorite_ids';

  /// Injected in tests; otherwise resolved lazily via [SharedPreferences.getInstance].
  SharedPreferences? _prefs;

  Future<SharedPreferences> _ensurePrefs() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  /// Loads persisted favorite IDs from device storage.
  Future<Set<int>> load() async {
    final prefs = await _ensurePrefs();
    final raw = prefs.getStringList(_key) ?? const <String>[];
    return raw.map(int.parse).toSet();
  }

  /// Saves favorite IDs to device storage (overwrite).
  Future<void> save(Set<int> ids) async {
    final prefs = await _ensurePrefs();
    await prefs.setStringList(
      _key,
      ids.map((e) => e.toString()).toList(growable: false),
    );
  }

  /// Clears all persisted favorites.
  Future<void> clear() async {
    final prefs = await _ensurePrefs();
    await prefs.remove(_key);
  }
}
