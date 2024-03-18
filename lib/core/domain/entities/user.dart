import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:identidaddigital/core/domain/entities/user_profile.dart';
import 'package:identidaddigital/core/domain/entities/user_permission.dart';

class User extends Equatable {
  final String deviceUID;
  final String deviceBrand;
  final String deviceModel;
  final String emailExt;
  final String emailUN;
  final String lastAccess;
  final UserPermission permission;

  const User({
    @required this.permission,
    @required this.deviceUID,
    @required this.deviceBrand,
    @required this.deviceModel,
    @required this.emailExt,
    @required this.emailUN,
    this.lastAccess,
  });

  @override
  String toString() {
    return permission.name;
  }

  @override
  List<Object> get props => [permission];

  /// Full user's name.
  String get name => permission.name;

  /// User's institutional id.
  String get id => permission.id;

  /// User's document.
  String get document => permission.document;

  /// Carnet picture
  String get picture => permission.picture;

  /// User profiles.
  List<UserProfile> get profiles => permission.profiles;

  /// Whether [this] has enough data to access the platform.
  bool get hasPermission => permission != null;

  /// Returns `false` if the user doesn't have a [picture].
  bool get canCreateCarnet => permission?.picture != null;

  /// Current used email.
  String get currentEmail => emailUN ?? emailExt;

  bool get mustChangePassword => emailExt != null && lastAccess == null;

  /// Creates a copy of this [User].
  User copyWith({
    String deviceUID,
    String deviceBrand,
    String deviceModel,
    String emailExt,
    String emailUN,
    String lastAccess,
    UserPermission permission,
  }) {
    return User(
      deviceUID: deviceUID ?? this.deviceUID,
      deviceBrand: deviceBrand ?? this.deviceBrand,
      deviceModel: deviceModel ?? this.deviceModel,
      emailExt: emailExt ?? this.emailExt,
      emailUN: emailUN ?? this.emailUN,
      permission: permission ?? this.permission,
      lastAccess: lastAccess ?? this.lastAccess,
    );
  }
}
