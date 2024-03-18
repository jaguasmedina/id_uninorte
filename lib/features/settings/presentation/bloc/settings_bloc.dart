import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/features/settings/domain/repositories/settings_repository.dart';

@injectable
class SettingsBloc extends BaseBloc {
  bool _biometricAccessEnabled, _areBiometricsSupported = false;
  final SettingsRepository _settingsRepository;

  SettingsBloc(this._settingsRepository);

  String get appVersion => _settingsRepository.appVersion;
  bool get areBiometricsSupported => _areBiometricsSupported;
  bool get biometricAccessEnabled => _biometricAccessEnabled;

  Future<void> setInitialValues() async {
    _biometricAccessEnabled = _settingsRepository.biometricAccessEnabled;
    _areBiometricsSupported =
        await _settingsRepository.areBiometricsAvailable();
    setState(PageState.idle);
  }

  void changeBiometricAccessEnabled({@required bool isEnabled}) {
    _biometricAccessEnabled = isEnabled;
    _settingsRepository.biometricAccessEnabled = isEnabled;
    setState(PageState.idle);
  }

  Future<Either<Failure, Unit>> unlinkDevice() {
    return _settingsRepository.unlinkDevice();
  }

  Future<void> logout() async {
    await _settingsRepository.logout();
  }
}
