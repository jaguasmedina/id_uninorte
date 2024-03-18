import 'package:dartz/dartz.dart';

import 'package:identidaddigital/core/data/api/request/login_request.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/error/error.dart';

/// Service to manage api authentication.
abstract class AuthService {
  /// Log into the platform.
  ///
  /// Returns a [Tuple2] containing the [UserModel] and a [String]
  /// representing the access token.
  ///
  /// Throws [DeviceAlreadyInUseException] if the device is already in use.
  Future<Tuple2<UserModel, String>> login(LoginRequest request);
}
