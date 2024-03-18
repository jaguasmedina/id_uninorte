import 'package:meta/meta.dart';

import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/models/user_permission_model.dart';
import 'package:identidaddigital/core/domain/entities/user.dart';

class UserModel extends User {
  @override
  final UserPermissionModel permission;

  const UserModel({
    @required this.permission,
    @required String deviceUID,
    @required String deviceBrand,
    @required String deviceModel,
    @required String emailExt,
    @required String emailUN,
    String lastAccess,
  }) : super(
          permission: permission,
          deviceUID: deviceUID,
          deviceBrand: deviceBrand,
          deviceModel: deviceModel,
          emailExt: emailExt,
          emailUN: emailUN,
          lastAccess: lastAccess,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      permission: UserPermissionModel.fromMap(map['permission']['data']),
      deviceUID: map['registerPhone']['data']['user_uid'],
      deviceBrand: map['registerPhone']['data']['user_phone_brand'],
      deviceModel: map['registerPhone']['data']['user_phone_model'],
      emailExt: map['registerPhone']['data']['user_email_ext'],
      emailUN: map['registerPhone']['data']['user_email_un'],
      lastAccess: map['registerPhone']['data']['user_last_access'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registerPhone': {
        'data': {
          'user_email_un': emailUN,
          'user_email_ext': emailExt,
          'user_uid': deviceUID,
          'user_phone_model': deviceModel,
          'user_phone_brand': deviceBrand,
          'user_last_access': lastAccess,
        }
      },
      'permission': {
        'data': permission.toMap(),
      }
    };
  }

  UserModel copyModel({
    UserPermissionModel permission,
    String deviceUID,
    String deviceBrand,
    String deviceModel,
    String emailExt,
    String emailUN,
    String lastAccess,
  }) {
    return UserModel(
      permission: permission ?? this.permission,
      deviceUID: deviceUID ?? this.deviceUID,
      deviceBrand: deviceBrand ?? this.deviceBrand,
      deviceModel: deviceModel ?? this.deviceModel,
      emailExt: emailExt ?? this.emailExt,
      emailUN: emailUN ?? this.emailUN,
      lastAccess: lastAccess ?? this.lastAccess,
    );
  }
}
