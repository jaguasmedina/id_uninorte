import 'package:flutter/widgets.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;
import 'package:identidaddigital/features/auth/domain/repositories/login_repository.dart';

@injectable
class LoginBloc extends BaseBloc {
  // State fields.
  bool _canUseBiometrics = false;
  AuthCredentials _storedCredentials;
  final AuthCredentials _credentials = AuthCredentials();

  // Repositories.
  final LoginRepository _loginRepository;

  LoginBloc({
    @required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  /// Whether fingerprint is avalable.
  bool get canUseBiometrics => _canUseBiometrics;

  /// Change username.
  ValueChanged<String> get changeUsername => _changeUsername;

  /// Change password.
  ValueChanged<String> get changePassword => _changePassword;

  FormFieldValidator<String> get validateUsername =>
      utils.FormValidators.validateEmptyUsername;

  FormFieldValidator<String> get validatePassword =>
      utils.FormValidators.validateEmptyPassword;

  void _changeUsername(String value) {
    _credentials.username = value;
  }

  void _changePassword(String value) {
    _credentials.password = value;
  }

  /// Checks if there are biometrics available.
  ///
  /// Returns `true` if biometrics are available and there are
  /// credentials already stored, otherwise returns `false`.
  Future<bool> shouldRequestBiometricsAutomatically() async {
    final biometricsChecked = await _loginRepository.areBiometricsAvailable();
    if (biometricsChecked) {
      final result = await _loginRepository.requestCredentials();
      if (result.isRight()) {
        _canUseBiometrics = true;
        _storedCredentials = result.getOrElse(null);
      } else {
        _canUseBiometrics = false;
      }
    } else {
      _canUseBiometrics = false;
    }
    setState(PageState.idle);
    return _canUseBiometrics;
  }

  /// Prompt local authentication.
  Future<bool> authenticateWithBiometrics(
    AppLocalizations localizations,
  ) async {
    return _loginRepository.authenticateWithBiometrics(localizations);
  }

  /// When [useLastEntry] is set to `true`, will perform the login with
  /// the stored credentials.
  Future<Either<Failure, User>> login({bool useLastEntry = false}) async {
    if (useLastEntry) {
      return _loginRepository.login(_storedCredentials);
    } else {
      return _loginRepository.login(_credentials);
    }
  }

  /// Launch privacy policies url.
  void launchPrivacyPolicies() {
    const url = 'https://www.uninorte.edu.co/politica-de-privacidad-de-datos';
    utils.IntentManager.launchUrl(url);
  }
}
