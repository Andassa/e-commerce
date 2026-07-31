import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';

/// Mock user profile (no auth backend). Profile & Settings screens watch this.
final userProfileProvider = Provider<UserProfile>((ref) {
  return UserProfile.mock;
});
