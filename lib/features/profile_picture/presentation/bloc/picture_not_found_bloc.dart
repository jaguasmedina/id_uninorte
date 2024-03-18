import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/file_manager_repository.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/picture_repository.dart';

@injectable
class PictureNotFoundBloc extends BaseBloc {
  File _selectedFile;
  PictureStatus _pictureStatus = const EmptyPictureStatus();
  final FileManagerRepository _fileManagerRepository;
  final PictureRepository _pictureRepository;

  PictureNotFoundBloc(
    this._fileManagerRepository,
    this._pictureRepository,
  );

  File get selectedFile => _selectedFile;

  PictureStatus get pictureStatus => _pictureStatus;

  /// Select an image from gallery.
  ///
  /// Returns `false` if cancelled.
  Future<bool> selectFile() async {
    final file = await _fileManagerRepository.pickImageFromGallery();
    if (file != null) {
      _selectedFile = file;
      return true;
    } else {
      return false;
    }
  }

  /// Request current picture status.
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

  void updatePictureStatusToPending() {
    _pictureStatus = const PendingPictureStatus();
    setState(PageState.idle);
  }
}
