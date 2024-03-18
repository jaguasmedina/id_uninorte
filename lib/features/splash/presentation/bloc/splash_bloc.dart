import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/domain/repositories/app_update_repository.dart';
import 'package:identidaddigital/core/domain/repositories/destination_repository.dart';
import 'package:identidaddigital/core/domain/repositories/remote_config_repository.dart';
import 'package:identidaddigital/core/navigation/destinations.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';

@injectable
class SplashBloc extends BaseBloc {
  final DestinationRepository _destinationRepository;
  final RemoteConfigRepository _remoteConfigRepository;
  final AppUpdateRepository _appUpdateRepository;

  SplashBloc(
    this._destinationRepository,
    this._remoteConfigRepository,
    this._appUpdateRepository,
  );

  /// Read inital Firebase configuration.
  ///
  /// Returns the initial destination.
  Future<String> initConfiguration() async {
    await _remoteConfigRepository.configure();

    final isUpdateRequired = await _appUpdateRepository.isUpdateRequired();

    if (isUpdateRequired) {
      return Destinations.updateRequired;
    }

    final initialDestination =
        _destinationRepository.requestInitialDestination();

    return initialDestination;
  }
}
