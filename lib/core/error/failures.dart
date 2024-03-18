import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  /// Key of the localized error [String] message.
  String get key;

  @override
  List<Object> get props => [];
}

class TypeFailure extends Failure {
  @override
  String get key => 'type_error_message';
}

class FormatFailure extends Failure {
  @override
  String get key => 'type_error_message';
}

class NetworkFailure extends Failure {
  @override
  String get key => 'network_error_message';
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure([this.message]);

  @override
  String get key => 'server_error_message';
}

class CredentialsNotFoundFailure extends Failure {
  @override
  String get key => 'error_message';
}

class UnexpectedFailure extends Failure {
  @override
  String get key => 'error_message';
}

class DeviceAlreadyInUseFailure extends Failure {
  @override
  String get key => null;
}

class NotAuthorizedFailure extends Failure {
  @override
  String get key => 'not_authorized_error_message';
}

class PictureNotFoundFailure extends Failure {
  @override
  String get key => 'picture_not_found_message';
}

class PermissionNotFoundFailure extends Failure {
  @override
  String get key => 'permission_not_found_message';
}

class SessionExpiredFailure extends Failure {
  @override
  String get key => 'session_expired_error_message';
}

class DeviceAlreadyUnlinkedFailure extends Failure {
  @override
  String get key => 'device_already_unlinked_error_message';
}

class ExternalUserMustChangePasswordFailure extends Failure {
  @override
  String get key => null;
}

class EmailNotFoundFailure extends Failure {
  @override
  String get key => 'email_not_found_error_message';
}

class DeviceInfoFailure extends Failure {
  @override
  String get key => 'device_info_error_message';
}

class AuthRequestFailure extends Failure {
  @override
  String get key => 'incorrect_auth_request';
}

class InternalServerFailure extends Failure {
  @override
  String get key => 'internal_server_error_message';
}
