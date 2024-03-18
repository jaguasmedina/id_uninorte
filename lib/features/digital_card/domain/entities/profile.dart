import 'package:flutter/painting.dart';

@Deprecated('User profiles are now represented by `UserProfile` class')
class Profile {
  final Color color;
  final String name;

  const Profile(this.name, this.color);
}
