import 'package:meta/meta.dart';
import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';

class UserPermissionModel extends UserPermission {
  @override
  final List<UserProfileModel> profiles;

  const UserPermissionModel({
    @required String id,
    @required String name,
    @required String document,
    @required String picture,
    @required this.profiles,
  }) : super(
          id: id,
          name: name,
          document: document,
          picture: picture,
          profiles: profiles,
        );

  factory UserPermissionModel.fromMap(Map map) {
    if (map == null) return null;
    return UserPermissionModel(
      id: map['id'],
      name: map['nombre'],
      document: map['documento'],
      picture: map['foto'],
      profiles: (map['perfilesnew'] as List)
          .map((dynamic e) => UserProfileModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'nombre': name,
      'documento': document,
      'foto': picture,
      'perfilesnew': profiles.map((e) => e.toMap()).toList(),
    };
  }
}
