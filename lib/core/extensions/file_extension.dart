import 'dart:io';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart' as mime;

extension FileExtension on File {
  /// Returns this [File] as a [MultipartFile].
  ///
  /// [field]: The form field to send to the request.
  Future<MultipartFile> toMultipartFile(String field) async {
    final mediaType = mime.lookupMimeType(path).split('/');
    final multipartFile = await MultipartFile.fromPath(
      field,
      path,
      contentType: MediaType(mediaType[0], mediaType[1]),
    );
    return multipartFile;
  }
}
