import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/user_profile.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/user_profile_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/profile_menu_tile.dart';

/// Mock user profile screen (no auth). Data comes from [userProfileProvider].
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserProfile user = ref.watch(userProfileProvider);
    final favs = ref.watch(favoritesProvider).length;
    final cart = ref.watch(cartProvider.notifier).itemCount;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage(user.avatarAsset),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              user.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            Text(
              user.email,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 4),
            Text(
              user.phone,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            Text(
              user.address,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              '$favs favorites · $cart in cart',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 28),
            ProfileMenuTile(
              icon: Icons.favorite_border,
              label: 'Favorites',
              onTap: () => context.push('/favorites'),
            ),
            ProfileMenuTile(
              icon: Icons.receipt_long_outlined,
              label: 'Orders',
              onTap: () => context.push('/orders'),
            ),
            ProfileMenuTile(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () => context.push('/settings'),
            ),
            const ProfileMenuTile(
              icon: Icons.ios_share,
              label: 'Share App',
            ),
            const ProfileMenuTile(
              icon: Icons.help_outline,
              label: 'Help',
            ),
            const SizedBox(height: 24),
            const Text(
              'Sign Out',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.signOut,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
