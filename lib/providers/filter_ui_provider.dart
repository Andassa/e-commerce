import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterGenderProvider = StateProvider<String>((ref) => 'All');
final filterBrandsProvider = StateProvider<Set<String>>((ref) => {'Puma', 'Nike', 'Supreme'});
final filterColorsProvider = StateProvider<Set<String>>((ref) => {'Black', 'Yellow', 'Green'});
final filterPriceRangeProvider = StateProvider<RangeValues>((ref) {
  return const RangeValues(16, 543);
});
