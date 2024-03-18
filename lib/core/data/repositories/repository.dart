import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/error/exceptions.dart';
import 'package:identidaddigital/core/error/failures.dart';

typedef ExceptionManagerCallback<T> = Future<Either<Failure, T>> Function();

/// Class used to encapsulate the logic required to access data sources.
abstract class Repository {
  /// Catch and discriminate all application exceptions.
  /// Returns [Either] a [Failure], if an exception is thrown, or [T],
  /// if the process is completed successfully.
  Future<Either<Failure, T>> runCatching<T>(
    ExceptionManagerCallback<T> callback,
  ) async {
    try {
      return await callback();
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on SocketException {
      return Left(NetworkFailure());
    } on FormatException {
      return Left(FormatFailure());
    } catch (e) {
      if (e is TypeError) {
        return Left(TypeFailure());
      }
      return Left(UnexpectedFailure());
    }
  }
}
