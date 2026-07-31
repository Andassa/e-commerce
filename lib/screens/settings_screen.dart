import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/app_back_button.dart';
import '../widgets/profile_menu_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Text('Account',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.soft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              title: Text('Mark Adam',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('Sunny_Koelpin45@hotmail.com',
                  style: TextStyle(color: AppColors.muted, fontSize: 12)),
              trailing: Icon(Icons.chevron_right, color: AppColors.muted),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          const Text('Setting',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
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
          const ProfileMenuTile(icon: Icons.privacy_tip_outlined, label: 'Privacy'),
          const ProfileMenuTile(icon: Icons.headset_mic_outlined, label: 'Help Center'),
          const ProfileMenuTile(icon: Icons.info_outline, label: 'About us'),
        ],
      ),
    );
  }
}
