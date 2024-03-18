import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/failures.dart';

abstract class UserPermissionRepository {
  /// Request and update user permissions.
  Future<Either<Failure, User>> updateUserPermission();
}
