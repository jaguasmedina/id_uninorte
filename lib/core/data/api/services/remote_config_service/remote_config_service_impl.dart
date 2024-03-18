import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/constants/api_routes.dart';
import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service.dart';
import 'package:identidaddigital/core/data/models/remote_config_model.dart';
import 'package:identidaddigital/core/enums/enums.dart';

@LazySingleton(as: RemoteConfigService)
@Environment(Env.prod)
class RemoteConfigServiceImpl implements RemoteConfigService {
  RemoteConfigServiceImpl(this._client);

  final ApiClient _client;

  @override
  Future<RemoteConfigModel> getConfig() async {
    final response = await _client.getUrl<dynamic>(ApiRoutes.getRemoteConfig);
    return RemoteConfigModel(
      minVersionCode: int.parse(response.data[0]['minVersionCode']),
      refreshTimeMilli: int.parse(response.data[0]['refreshTimeMillis']),
    );
  }
}
