import 'package:identidaddigital/core/error/failures.dart';

abstract class AppException implements Exception {
  /// Returns a [Failure] representation of this [Exception].
  Failure toFailure();
}

class NetworkException extends AppException {
  @override
  Failure toFailure() => NetworkFailure();
}

class ServerException extends AppException {
  final String message;

  ServerException([this.message]);

  @override
  Failure toFailure() => ServerFailure(message);
}

class CredentialsNotFoundException extends AppException {
  @override
  Failure toFailure() => CredentialsNotFoundFailure();
}

class UnexpectedException extends AppException {
  @override
  Failure toFailure() => UnexpectedFailure();
}

class DeviceAlreadyInUseException extends AppException {
  @override
  Failure toFailure() => DeviceAlreadyInUseFailure();
}

class NotAuthorizedException extends AppException {
  @override
  Failure toFailure() => NotAuthorizedFailure();
}

class PermissionNotFoundException extends AppException {
  @override
  Failure toFailure() => PermissionNotFoundFailure();
}

class SessionExpiredException extends AppException {
  @override
  Failure toFailure() => SessionExpiredFailure();
}

class DeviceAlreadyUnlinkedException extends AppException {
  @override
  Failure toFailure() => DeviceAlreadyUnlinkedFailure();
}

class ExternalUserMustChangePasswordException extends AppException {
  @override
  Failure toFailure() => ExternalUserMustChangePasswordFailure();
}

class EmailNotFoundException extends AppException {
  @override
  Failure toFailure() => EmailNotFoundFailure();
}

class DeviceInfoException extends AppException {
  @override
  Failure toFailure() => DeviceInfoFailure();
}

class AuthRequestException extends AppException {
  @override
  Failure toFailure() => AuthRequestFailure();
}

class InternalServerException extends AppException {
  @override
  Failure toFailure() => InternalServerFailure();
}
