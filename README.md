# Shop Hub

Flutter e-commerce app: catalog from FakeStoreAPI, cart, favorites, search/filter, checkout mock, and profile flows.

**Stack:** Flutter 3 · Riverpod · go_router · http · shared_preferences · cached_network_image

---

## Design goals (for reviewers)

| Goal | How it shows up in code |
|------|-------------------------|
| No spaghetti | UI never calls HTTP or SharedPreferences directly |
| One responsibility per layer | Screen → Provider → Repository / Datasource → API or local storage |
| Thin screens | Screens `watch` / `read` providers; widgets stay reusable and dumb |
| Predictable state | Async catalog via `FutureProvider`; cart & favorites via `StateNotifierProvider` |
| Easy to swap data source | `ProductRepository` is injectable (`http.Client`); favorites isolated in a datasource |

---

## Architecture

```
lib/
  main.dart              ProviderScope + MaterialApp.router
  models/                Product, CartItem, SortOption (immutable data)
  data/                  ProductRepository, FavoritesLocalDatasource
  providers/             All app state (no widgets here)
  screens/               Route pages only — compose widgets + watch providers
  widgets/               Reusable UI pieces (cards, bars, tiles, etc.)
  router/                go_router: shell tabs + stacked routes
  theme/                 AppColors + AppTheme
```

**Data flow**

```
Screen / Widget
      │  ref.watch / ref.read
      ▼
Provider (Riverpod)
      │
      ├──► ProductRepository ──► FakeStoreAPI (https://fakestoreapi.com)
      └──► FavoritesLocalDatasource ──► shared_preferences
```

Rules used throughout:

1. **Providers own logic** (filter, sort, cart totals, persistence).
2. **Repositories own I/O** (HTTP, JSON parse, error mapping).
3. **Screens own layout** and navigation only.

---

## Features

- Home: greeting, promo banner, Featured / Most Popular horizontal lists
- Catalog: category chips, sort dropdown, filtered product grid
- Search & filter screens (query + category + sort composed in one provider)
- Product detail: hero image, size selector, add to cart, favorite toggle
- Cart: quantity controls, badge on bottom nav, clear / checkout
- Checkout mock + order history UI
- Favorites persisted locally across app restarts
- Profile & settings navigation

---

## Providers

| Provider | Type | Role |
|----------|------|------|
| `productRepositoryProvider` | `Provider` | Exposes `ProductRepository` |
| `productsProvider` | `FutureProvider` | Full catalog (`AsyncValue`) |
| `categoriesProvider` | `FutureProvider` | FakeStore categories |
| `productByIdProvider` | `FutureProvider.family` | Single product by id |
| `categoryFilterProvider` | `StateProvider` | Selected category (`null` = all) |
| `sortOptionProvider` | `StateProvider` | Price asc/desc, name A–Z |
| `searchQueryProvider` | `StateProvider` | Search text |
| `filteredProductsProvider` | `Provider` | Catalog ∩ category ∩ search ∩ sort |
| `cartProvider` | `StateNotifierProvider` | Add / remove / qty / clear / total |
| `favoritesProvider` | `StateNotifierProvider` | Favorite ids + local sync |
| `paymentMethodProvider` | `StateProvider` | Checkout payment selection |
| `filterUiProvider` | UI draft state for filter screen |

Derived lists (`filteredProductsProvider`) never re-fetch: they recompute from cached async data + filter state.

---

## Navigation (`go_router`)

**Bottom shell (StatefulShellRoute):** `/home` · `/search` · `/cart` · `/profile`

**Stacked routes:** `/products` · `/product/:id` · `/favorites` · `/checkout` · `/orders` · `/filter` · `/settings`

Cart badge count comes from `cartProvider` inside `ShellScaffold`.

---

## Screenshots

| Screen | Capture |
|--------|---------|
| Home | ![Home](capture/Home.png) |
| Search | ![Search](capture/search.png) |
| Filter | ![Filter](capture/filter.png) |
| Product detail | ![Details](capture/details.png) |
| Add to cart | ![Add to cart](capture/details_addtocart.png) |
| Cart | ![Cart](capture/cart.png) |
| Checkout | ![Checkout](capture/checkout.png) |
| Order history | ![Orders](capture/order_history.png) |
| Profile | ![Profile](capture/profile.png) |
| Settings | ![Settings](capture/settings.png) |

---

## Setup

```bash
flutter pub get
flutter run
```

Requires Flutter 3.x and network access to FakeStoreAPI.

---

## Project map (where to look)

| Concern | Start here |
|---------|------------|
| App entry & theme | `lib/main.dart`, `lib/theme/` |
| Routes | `lib/router/app_router.dart` |
| API | `lib/data/product_repository.dart` |
| Local favorites | `lib/data/favorites_local_datasource.dart` |
| Catalog / filter / sort | `lib/providers/product_providers.dart`, `filtered_products_provider.dart` |
| Cart | `lib/providers/cart_provider.dart` |
| Favorites | `lib/providers/favorites_provider.dart` |
| UI pages | `lib/screens/` |
| Shared UI | `lib/widgets/` |

---

## Notes

- Checkout and order history are **UI mocks** (no payment backend).
- Product images use `cached_network_image`.
- Package name: `shop_hub`.
