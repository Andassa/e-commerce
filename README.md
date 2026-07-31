# Shop Hub

Flutter e-commerce app built with Riverpod, go_router and FakeStoreAPI.

## Features

- Product catalog from FakeStoreAPI with category filter and sort
- Product detail, cart with quantity controls, checkout mock
- Favorites persisted with shared_preferences
- Search, filter UI, orders, profile and settings screens
- Bottom navigation with cart badge

## Architecture

```
lib/
  main.dart                 ProviderScope + MaterialApp.router
  models/                   Product, CartItem, SortOption
  data/                     ProductRepository, FavoritesLocalDatasource
  providers/                Riverpod providers (no UI logic)
  screens/                  UI only: watch / read providers
  widgets/                  Reusable UI pieces
  router/                   go_router routes
  theme/                    Colors and ThemeData
```

Flow: `Screen` → `Provider` → `Repository / Datasource` → API or local storage.

## Providers

| Provider | Type | Role |
|---|---|---|
| `productRepositoryProvider` | `Provider` | Exposes `ProductRepository` |
| `productsProvider` | `FutureProvider` | Loads all products (AsyncValue) |
| `categoriesProvider` | `FutureProvider` | Loads FakeStore categories |
| `productByIdProvider` | `FutureProvider.family` | Loads one product by id |
| `categoryFilterProvider` | `StateProvider` | Selected category (`null` = all) |
| `sortOptionProvider` | `StateProvider` | Sort: price asc/desc, name A-Z |
| `searchQueryProvider` | `StateProvider` | Text text filter |
| `filteredProductsProvider` | `Provider` | Combines catalog + category + search + sort |
| `cartProvider` | `StateNotifierProvider` | Cart add/remove/qty/clear/total |
| `favoritesProvider` | `StateNotifierProvider` | Favorite ids + shared_preferences sync |

## Setup

```bash
flutter pub get
flutter run
```

Requires Flutter 3.x and network access for FakeStoreAPI.

## Screenshots

Place captures here:

- `docs/home.png`
- `docs/catalog.png`
- `docs/detail.png`
- `docs/cart.png`
- `docs/profile.png`
# e-commerce
