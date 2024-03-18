import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class ImagePickerDataSource {
  Future<File> pickImageFromGallery();
  Future<File> pickImageFromCamera();
}

@LazySingleton(as: ImagePickerDataSource)
class ImagePickerDataSourceImpl implements ImagePickerDataSource {
  /// Image max width and height.
  static const double maxSize = 600.0;

  final ImagePicker imagePicker;

  ImagePickerDataSourceImpl(this.imagePicker);

  @override
  Future<File> pickImageFromCamera() {
    return _pickImageFile(ImageSource.camera);
  }

  @override
  Future<File> pickImageFromGallery() async {
    final image = await _pickImageFile(ImageSource.gallery);

    //Esto no funciona en Android 13 y posteriores
    // if (Platform.isAndroid && image != null && image.path != null) {
    //   image = await FlutterExifRotation.rotateImage(path: image.path);
    // }
    return image;
  }

  Future<File> _pickImageFile(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(
      source: source,
      maxWidth: maxSize,
      maxHeight: maxSize,
    );
    return File(pickedFile.path);
  }
}
