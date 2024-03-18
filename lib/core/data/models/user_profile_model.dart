import 'package:meta/meta.dart';
import 'package:identidaddigital/core/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    @required String name,
    @required String title,
    @required String colorHexStr,
  })  : assert(name != null),
        assert(title != null),
        assert(colorHexStr != null),
        super(
          name: name,
          title: title,
          colorHexStr: colorHexStr,
        );

  factory UserProfileModel.fromMap(Map map) {
    return UserProfileModel(
      name: map['name'],
      title: map['titulo'],
      colorHexStr: map['color'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'name': name,
      'titulo': title,
      'color': colorHexStr,
    };
  }
}
