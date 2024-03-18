import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';

abstract class LoginRepository {
  /// Log into the platform and get user's data.
  Future<Either<Failure, User>> login(AuthCredentials credentials);

  /// Check if there are available biometrics.
  Future<bool> areBiometricsAvailable();

  /// Authenticate with biometrics.
  Future<bool> authenticateWithBiometrics(AppLocalizations localizations);

  /// Read user last stored credentials.
  Future<Either<Failure, AuthCredentials>> requestCredentials();

  /// Change the current password of the user. [credentiasl.username] must be
  /// the email of an external user.
  Future<Either<Failure, Unit>> changePasswordForExternalUser(
      AuthCredentials credentials);
}
