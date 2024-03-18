import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';

abstract class SecureStorageDataSource {
  /// Read user's credentials.
  Future<AuthCredentials> requestCredentials();

  /// Store user's credentials.
  Future<void> storeCredentials(AuthCredentials credentials);

  /// Delete user's credentials.
  Future<void> deleteCredentials();
}

@LazySingleton(as: SecureStorageDataSource)
class SecureStorageDataSourceImpl implements SecureStorageDataSource {
  final FlutterSecureStorage secureStorage;

  static const String usernameStorageKey = 'USERNAME_SECURE_KEY';
  static const String passwordStorageKey = 'PASSWORD_SECURE_KEY';

  SecureStorageDataSourceImpl(this.secureStorage);

  @override
  Future<AuthCredentials> requestCredentials() async {
    final username = await secureStorage.read(key: usernameStorageKey);
    final password = await secureStorage.read(key: passwordStorageKey);
    if (username != null && password != null) {
      return AuthCredentials(
        username: username,
        password: password,
      );
    } else {
      throw CredentialsNotFoundException();
    }
  }

  @override
  Future<void> storeCredentials(AuthCredentials credentials) async {
    await secureStorage.write(
      key: usernameStorageKey,
      value: credentials.username,
    );
    await secureStorage.write(
      key: passwordStorageKey,
      value: credentials.password,
    );
  }

  @override
  Future<void> deleteCredentials() async {
    await secureStorage.deleteAll();
  }
}
