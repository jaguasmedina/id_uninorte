import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/picture_repository.dart';

@injectable
class UploadPictureBloc extends BaseBloc {
  final PictureRepository _pictureRepository;

  UploadPictureBloc(
    this._pictureRepository,
  );

  Future<Either<Failure, Unit>> uploadPicture(File file) async {
    final result = await _pictureRepository.uploadPicture(file);
    return result;
  }
}
