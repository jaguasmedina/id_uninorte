import 'package:equatable/equatable.dart';
import 'package:identidaddigital/core/domain/entities/user_profile.dart';

class UserPermission extends Equatable {
  final String id;
  final String name;
  final String document;
  final String picture;
  final List<UserProfile> profiles;

  const UserPermission({
    required this.id,
    required this.name,
    required this.document,
    required this.picture,
    required this.profiles,
  });

  @override
  List<Object?> get props => [id];
}
