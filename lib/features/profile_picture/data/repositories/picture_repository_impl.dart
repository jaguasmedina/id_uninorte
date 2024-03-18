import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/entities/picture_status.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/picture_repository.dart';

@LazySingleton(as: PictureRepository)
class PictureRepositoryImpl extends Repository implements PictureRepository {
  final ProfileService profileService;
  final PreferencesDataSource preferences;
  final NetworkInfoDataSource networkInfo;

  PictureRepositoryImpl(
    this.profileService,
    this.preferences,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, PictureStatus>> requestCurrentPictureStatus() {
    return runCatching(() async {
      await networkInfo.ensureConnection();
      final user = preferences.user;
      final response = await profileService.requestPictureStatus(user.document);
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, Unit>> uploadPicture(File picture) {
    return runCatching(() async {
      await networkInfo.ensureConnection();
      final user = preferences.user;
      await profileService.uploadPicture(user.document, picture);
      return const Right(unit);
    });
  }
}
