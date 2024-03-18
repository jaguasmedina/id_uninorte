import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/domain/repositories/user_permission_repository.dart';
import 'package:identidaddigital/core/error/error.dart';

@LazySingleton(as: UserPermissionRepository)
class UserPermissionRepositoryImpl extends Repository
    implements UserPermissionRepository {
  final ProfileService profileService;
  final PreferencesDataSource preferences;
  final NetworkInfoDataSource networkInfo;

  UserPermissionRepositoryImpl(
    this.profileService,
    this.preferences,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, User>> updateUserPermission() {
    return runCatching(() async {
      try {
        await networkInfo.ensureConnection();
        final user = preferences.user;
        final permission = await profileService.requestUserPermission(
          user.document,
          user.currentEmail,
        );
        final UserModel updatedUser = user.copyModel(permission: permission);
        preferences.user = updatedUser;
        preferences.permissionsLastUpdatedTime = Timestamp.now();
        return Right(updatedUser);
      } on PermissionNotFoundException catch (e) {
        await forceLogout();
        return Left(e.toFailure());
      } on SessionExpiredException {
        await forceLogout();
        return Left(PermissionNotFoundFailure());
      } on AppException catch (e) {
        if (shouldForceLogout()) {
          await forceLogout();
          return Left(PermissionNotFoundFailure());
        } else {
          return Left(e.toFailure());
        }
      }
    });
  }

  bool shouldForceLogout() {
    final lastUpdatedTime = preferences.permissionsLastUpdatedTime;
    return lastUpdatedTime != null && lastUpdatedTime.isExpired;
  }

  Future<void> forceLogout() async {
    await preferences.clearUserData();
  }
}
