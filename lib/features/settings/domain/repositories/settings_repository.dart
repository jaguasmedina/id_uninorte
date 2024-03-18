import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';

abstract class SettingsRepository {
  /// Application version name.
  String get appVersion;

  /// Whether authentication with biometrics is enabled.
  bool get biometricAccessEnabled;

  set biometricAccessEnabled(bool value);

  /// Check if there are available biometrics.
  Future<bool> areBiometricsAvailable();

  /// Unlink the current user device.
  Future<Either<Failure, Unit>> unlinkDevice();

  /// Close the session. Clean user stored data.
  Future<void> logout();

  /// Sends a message.
  Future<Either<Failure, Unit>> sendMessage(Message message);
}
