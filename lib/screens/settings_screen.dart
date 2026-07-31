import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';
import '../providers/user_profile_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_back_button.dart';
import '../widgets/profile_menu_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserProfile user = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text(
            'Account',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.soft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(user.avatarAsset),
              ),
              title: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                user.email,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          const Text(
            'Setting',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          const ProfileMenuTile(
            icon: Icons.notifications_none,
            label: 'Notification',
          ),
          const ProfileMenuTile(
            icon: Icons.language,
            label: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('English', style: TextStyle(color: AppColors.muted)),
                Icon(Icons.chevron_right, color: AppColors.muted),
              ],
            ),
          ),
          const ProfileMenuTile(
            icon: Icons.privacy_tip_outlined,
            label: 'Privacy',
          ),
          const ProfileMenuTile(
            icon: Icons.headset_mic_outlined,
            label: 'Help Center',
          ),
          const ProfileMenuTile(
            icon: Icons.info_outline,
            label: 'About us',
          ),
        ],
      ),
    );
  }
}
