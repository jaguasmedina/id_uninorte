import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info/device_info.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/file_manager_repository.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/picture_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class ProfilePictureBloc extends BaseBloc {
  File _selectedFile;
  PictureStatus _pictureStatus = const EmptyPictureStatus();
  final FileManagerRepository _fileManagerRepository;
  final PictureRepository _pictureRepository;

  ProfilePictureBloc(
    this._fileManagerRepository,
    this._pictureRepository,
  );

  File get selectedFile => _selectedFile;
  PictureStatus get pictureStatus => _pictureStatus;
  Function get selectFile => _selectFile;

  Future<void> _selectFile() async {
    final PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      final file = await _fileManagerRepository.pickImageFromGallery();

      if (file != null) {
        _selectedFile = file;
        setState(PageState.idle);
      }
    }
    if (status.isDenied || status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> requestPictureStatus() async {
    final result = await _pictureRepository.requestCurrentPictureStatus();
    result.fold(
      (failure) => null,
      (pictureStatus) {
        _pictureStatus = pictureStatus;
        setState(PageState.idle);
      },
    );
  }

  Future<Either<Failure, Unit>> uploadPicture() async {
    setState(PageState.busy);
    final result = await _pictureRepository.uploadPicture(selectedFile);
    result.fold(
      (failure) {
        setState(PageState.idle);
      },
      (_) {
        _pictureStatus = const PendingPictureStatus();
        _selectedFile = null;
        setState(PageState.idle);
      },
    );
    return result;
  }
}
