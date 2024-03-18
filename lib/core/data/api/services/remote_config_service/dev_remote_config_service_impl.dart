import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service.dart';
import 'package:identidaddigital/core/data/models/remote_config_model.dart';
import 'package:identidaddigital/core/enums/enums.dart';

@LazySingleton(as: RemoteConfigService)
@Environment(Env.dev)
class DevRemoteConfigServiceImpl implements RemoteConfigService {
  @override
  Future<RemoteConfigModel> getConfig() {
    return Future.sync(
      () => RemoteConfigModel(
        minVersionCode: 2,
        refreshTimeMilli: 5e3.toInt(),
      ),
    );
  }
}
