enum SortOption {
  priceAsc,
  priceDesc,
  nameAsc,
}

extension SortOptionX on SortOption {
  String get label => switch (this) {
        SortOption.priceAsc => 'Price: Low to High',
        SortOption.priceDesc => 'Price: High to Low',
        SortOption.nameAsc => 'Name: A-Z',
      };
}
