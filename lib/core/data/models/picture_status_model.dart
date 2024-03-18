import 'package:identidaddigital/core/domain/entities/picture_status.dart';

class PictureStatusModel extends PictureStatus {
  const PictureStatusModel(
    String status,
    String message,
  ) : super(status, message);

  factory PictureStatusModel.fromMap(Map map) {
    return PictureStatusModel(
      map['state'],
      map['message'],
    );
  }
}
