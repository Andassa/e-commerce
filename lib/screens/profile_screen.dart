import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/profile_menu_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoritesProvider).length;
    final cart = ref.watch(cartProvider).fold(0, (s, e) => s + e.quantity);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Mark Adam',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const Text(
              'Sunny_Koelpin45@hotmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 8),
            Text(
              '$favs favorites · $cart in cart',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 28),
            ProfileMenuTile(
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: () => context.push('/favorites'),
            ),
            ProfileMenuTile(
              icon: Icons.settings_outlined,
              label: 'Setting',
              onTap: () => context.push('/settings'),
            ),
            ProfileMenuTile(
              icon: Icons.mail_outline,
              label: 'Contact',
              onTap: () => context.push('/orders'),
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
