import 'dart:io';

import 'package:meta/meta.dart';

import 'package:injectable/injectable.dart';
import 'package:local_auth/auth_strings.dart';
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

  BiometricsDataSourceImpl({@required this.localAuthentication});

  @override
  Future<bool> authenticate(AppLocalizations localizations) {
    return localAuthentication.authenticate(
      localizedReason: localizations.translate('local_auth_reason'),
      androidAuthStrings: AndroidAuthMessages(
        cancelButton: localizations.translate('local_auth_cancel_button'),
        biometricHint: localizations.translate('local_auth_hint'),
        signInTitle: localizations.translate('local_auth_title'),
      ),
      iOSAuthStrings: IOSAuthMessages(
        cancelButton: localizations.translate('local_auth_cancel_button'),
        goToSettingsButton: localizations.translate('local_auth_settings'),
        goToSettingsDescription:
            localizations.translate('local_auth_settings_description'),
      ),
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
