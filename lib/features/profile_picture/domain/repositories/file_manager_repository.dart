import 'dart:io';

abstract class FileManagerRepository {
  /// Picks an image file from the device's gallery.
  ///
  /// Returns `null` if none image is selected.
  Future<File> pickImageFromGallery();

  /// Picks an image file from the device's camera.
  ///
  /// Returns `null` if none image is selected.
  Future<File> pickImageFromCamera();
}
