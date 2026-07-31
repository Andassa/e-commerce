import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_hub/models/user_profile.dart';
import 'package:shop_hub/providers/user_profile_provider.dart';
import 'package:shop_hub/screens/profile_screen.dart';
import 'package:shop_hub/widgets/loading_error_view.dart';

void main() {
  testWidgets('LoadingErrorView shows loading then data', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoadingErrorView<String>(
          value: const AsyncLoading(),
          onRetry: () {},
          builder: (data) => Text(data),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: LoadingErrorView<String>(
          value: const AsyncData('Ready'),
          onRetry: () {},
          builder: (data) => Text(data),
        ),
      ),
    );
    expect(find.text('Ready'), findsOneWidget);
  });

  testWidgets('LoadingErrorView shows error and Retry', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      MaterialApp(
        home: LoadingErrorView<String>(
          value: AsyncError('boom', StackTrace.empty),
          onRetry: () => retried = true,
          builder: (data) => Text(data),
        ),
      ),
    );
    expect(find.text('boom'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });

  testWidgets('ProfileScreen shows mock user from provider', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userProfileProvider.overrideWithValue(
            const UserProfile(
              name: 'Test User',
              email: 'test@example.com',
              avatarAsset: 'assets/images/profile.jpg',
            ),
          ),
        ],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
