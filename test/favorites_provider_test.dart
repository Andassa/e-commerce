import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_hub/data/favorites_local_datasource.dart';
import 'package:shop_hub/providers/favorites_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Favorites persistence', () {
    late FavoritesLocalDatasource ds;
    late FavoritesNotifier notifier;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      ds = FavoritesLocalDatasource(prefs: prefs);
      notifier = FavoritesNotifier(ds);
      await notifier.loadFromLocalStorage();
    });

    test('toggleFavorite saves to datasource', () async {
      await notifier.toggleFavorite(7);
      expect(notifier.isFavorite(7), isTrue);
      expect(await ds.load(), {7});

      await notifier.toggleFavorite(7);
      expect(notifier.isFavorite(7), isFalse);
      expect(await ds.load(), isEmpty);
    });

    test('loadFromLocalStorage hydrates previous values', () async {
      await ds.save({3, 9});
      final other = FavoritesNotifier(ds);
      await other.loadFromLocalStorage();
      expect(other.state, {3, 9});
    });

    test('clearFavorites wipes storage', () async {
      await notifier.toggleFavorite(1);
      await notifier.clearFavorites();
      expect(notifier.state, isEmpty);
      expect(await ds.load(), isEmpty);
    });
  });
}
