import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_hub/main.dart';

void main() {
  testWidgets('Shop Hub boots', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ShopHubApp()));
    expect(find.byType(ShopHubApp), findsOneWidget);
  });
}
