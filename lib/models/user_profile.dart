/// Mock authenticated user shown on Profile & Settings screens.
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.avatarAsset,
    this.phone = '+1 555 0100',
    this.address = '221B Baker Street, London',
  });

  final String name;
  final String email;
  final String avatarAsset;
  final String phone;
  final String address;

  static const mock = UserProfile(
    name: 'Mark Adam',
    email: 'Sunny_Koelpin45@hotmail.com',
    avatarAsset: 'assets/images/profile.jpg',
  );
}
