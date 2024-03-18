import 'dart:io';

import 'package:identidaddigital/core/data/models/models.dart';

abstract class ProfileService {
  /// Upload a new photo to change the card.
  Future<void> uploadPicture(String userId, File image);

  /// Request the current user permissions.
  Future<UserPermissionModel> requestUserPermission(String id, String email);

  /// Returns the current picture status.
  ///
  /// [document]: User's document.
  Future<PictureStatusModel> requestPictureStatus(String document);

  /// Change the current password of the user. [credentiasl.username] must be
  /// the email of an external user.
  Future<void> changePasswordForExternalUser(AuthCredentialsModel credentials);

  /// Sends a message.
  Future<void> sendMessageToContactCenter(MessageModel message);

  /// Returns the encode qr code.
  Future<String> encodeAccessInfo(String id, int timestamp);
}
