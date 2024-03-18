import 'package:identidaddigital/core/domain/entities/user_profile.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class UserPermission extends Equatable {
  final String id;
  final String name;
  final String document;
  final String picture;
  final List<UserProfile> profiles;

  const UserPermission({
    @required this.id,
    @required this.name,
    @required this.document,
    @required this.picture,
    @required this.profiles,
  });

  @override
  List<Object> get props => [id];
}
