import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service.dart';
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/domain/entities/remote_config.dart';
import 'package:identidaddigital/core/domain/repositories/remote_config_repository.dart';

@LazySingleton(as: RemoteConfigRepository)
class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final RemoteConfigService remoteConfigService;
  final NetworkInfoDataSource networkInfo;
  final PreferencesDataSource preferences;

  RemoteConfigRepositoryImpl(
    this.remoteConfigService,
    this.networkInfo,
    this.preferences,
  );

  @override
  RemoteConfig get config => preferences.remoteConfig;

  @override
  Future<void> configure() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteConfig = await remoteConfigService.getConfig();
        await preferences.setRemoteConfig(remoteConfig);
        await Future<void>.delayed(const Duration(milliseconds: 200));
      }
    } catch (e) {}
  }
}
