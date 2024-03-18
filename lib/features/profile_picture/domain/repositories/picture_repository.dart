import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';

abstract class PictureRepository {
  /// Upload user picture.
  Future<Either<Failure, Unit>> uploadPicture(File picture);

  /// Request the user's current picture status.
  Future<Either<Failure, PictureStatus>> requestCurrentPictureStatus();
}
