import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:identidaddigital/features/profile_picture/data/data_sources/image_picker_data_source.dart';
import 'package:identidaddigital/features/profile_picture/domain/repositories/file_manager_repository.dart';

@LazySingleton(as: FileManagerRepository)
class FileManagerRepositoryImpl implements FileManagerRepository {
  final ImagePickerDataSource imagePickerDataSource;

  FileManagerRepositoryImpl(this.imagePickerDataSource);

  @override
  Future<File> pickImageFromCamera() async {
    try {
      final file = await imagePickerDataSource.pickImageFromCamera();
      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<File> pickImageFromGallery() async {
    try {
      final file = await imagePickerDataSource.pickImageFromGallery();
      return file;
    } catch (e) {
      return null;
    }
  }
}
