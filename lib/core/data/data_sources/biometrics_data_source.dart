import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';

abstract class BiometricsDataSource {
  /// Check if there are available biometrics.
  Future<bool> areBiometricsAvailable();

  /// Authenticate with biometrics.
  Future<bool> authenticate(AppLocalizations localizations);
}

@LazySingleton(as: BiometricsDataSource)
class BiometricsDataSourceImpl implements BiometricsDataSource {
  final LocalAuthentication localAuthentication;

  BiometricsDataSourceImpl({required this.localAuthentication});

  @override
  Future<bool> authenticate(AppLocalizations localizations) {
    return localAuthentication.authenticate(
      localizedReason: localizations.translate('local_auth_reason'),
    );
  }

  @override
  Future<bool> areBiometricsAvailable() async {
    final hasBiometrics = await localAuthentication.canCheckBiometrics;
    if (hasBiometrics && Platform.isIOS) {
      final availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      return availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.face);
    } else {
      return hasBiometrics;
    }
  }
}
