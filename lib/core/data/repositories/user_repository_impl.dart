import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/domain/entities/user.dart';
import 'package:identidaddigital/core/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final PreferencesDataSource preferencesDataSource;

  UserRepositoryImpl(this.preferencesDataSource);

  @override
  User? getUser() {
    return preferencesDataSource.user;
  }

  @override
  void updateUser(User? user) {
    if (user is UserModel) {
      preferencesDataSource.user = user;
    } else if (user == null) {
      preferencesDataSource.user = null;
    }
  }

  @override
  void clearUser() {
    preferencesDataSource.clearUserData();
  }
}
