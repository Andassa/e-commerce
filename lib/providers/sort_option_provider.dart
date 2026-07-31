import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sort_option.dart';

final sortOptionProvider = StateProvider<SortOption>((ref) => SortOption.priceAsc);
