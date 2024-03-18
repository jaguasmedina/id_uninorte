import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';

abstract class PreferencesDataSource {
  /// Read user data.
  UserModel get user;

  /// Store user data.
  set user(UserModel model);

  /// Authorization token.
  String get authToken;

  set authToken(String token);

  /// Email
  String get userEmail;

  set userEmail(String token);

  /// Whether authentication with biometrics is enabled.
  bool get biometricAccessEnabled;

  set biometricAccessEnabled(bool value);

  /// Remote configuration object.
  RemoteConfigModel get remoteConfig;

  Future<void> setRemoteConfig(RemoteConfigModel value);

  /// Last time where the user permissions was updated.
  Timestamp get permissionsLastUpdatedTime;

  set permissionsLastUpdatedTime(Timestamp timestamp);

  /// Whether the onboarding did show.
  bool get onboardingDidShow;

  set onboardingDidShow(bool didShow);

  /// Clear all user related data.
  Future<void> clearUserData();
}

@LazySingleton(as: PreferencesDataSource)
class PreferencesDataSourceImpl implements PreferencesDataSource {
  final SharedPreferences preferences;
  // storage keys
  static const _kAuthToken = 'AUTH_TOKEN_KEY';
  static const _kUser = 'USER_KEY';
  static const _kBiomatricAccessEnabled = 'BIOMETRIC_ACCESS_ENABLED_KEY';
  static const _kFirebaseConfig = 'CONFIGURABLE_DATA';
  static const _kPermissionsLastUpdatedTime = 'PERMISSIONS_LAST_UPDATED_TIME';
  static const _kOnboardingDidShow = 'ONBOARDING_DID_SHOW';
  static const _kEmail = 'USER_EMAIL';

  PreferencesDataSourceImpl({
    @required this.preferences,
  });

  @override
  String get authToken {
    final token = preferences.getString(_kAuthToken);
    return token;
  }

  @override
  set authToken(String value) {
    preferences.setString(_kAuthToken, value);
  }


  @override
  String get userEmail {
    final email = preferences.getString(_kEmail);
    return email;
  }

  @override
  set userEmail(String value) {
    preferences.setString(_kEmail, value);
  }

  @override
  UserModel get user {
    try {
      final data = preferences.getString(_kUser);
      if (data != null) {
        return UserModel.fromMap(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  set user(UserModel model) {
    final encodedModel = json.encode(model.toMap());
    preferences.setString(_kUser, encodedModel);
  }

  @override
  bool get biometricAccessEnabled {
    final value = preferences.getBool(_kBiomatricAccessEnabled);
    return value ?? true;
  }

  @override
  set biometricAccessEnabled(bool value) {
    preferences.setBool(_kBiomatricAccessEnabled, value);
  }

  @override
  RemoteConfigModel get remoteConfig {
    try {
      final data = preferences.getString(_kFirebaseConfig);
      if (data != null) {
        return RemoteConfigModel.fromMap(json.decode(data));
      } else {
        return RemoteConfigModel.initial();
      }
    } catch (e) {
      return RemoteConfigModel.initial();
    }
  }

  @override
  Future<void> setRemoteConfig(RemoteConfigModel model) {
    final encodedModel = json.encode(model.toMap());
    return preferences.setString(_kFirebaseConfig, encodedModel);
  }

  @override
  Timestamp get permissionsLastUpdatedTime {
    final data = preferences.getInt(_kPermissionsLastUpdatedTime);
    if (data != null) {
      return Timestamp(data);
    } else {
      return null;
    }
  }

  @override
  set permissionsLastUpdatedTime(Timestamp timestamp) {
    preferences.setInt(_kPermissionsLastUpdatedTime, timestamp.seconds);
  }

  @override
  bool get onboardingDidShow {
    return preferences.getBool(_kOnboardingDidShow) ?? false;
  }

  @override
  set onboardingDidShow(bool didShow) {
    preferences.setBool(_kOnboardingDidShow, didShow);
  }

  @override
  Future<void> clearUserData() async {
    await preferences.remove(_kUser);
    await preferences.remove(_kAuthToken);
    await preferences.remove(_kPermissionsLastUpdatedTime);
  }
}
