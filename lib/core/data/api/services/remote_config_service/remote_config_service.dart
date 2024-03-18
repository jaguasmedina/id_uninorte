import 'package:identidaddigital/core/data/models/models.dart';

abstract class RemoteConfigService {
  Future<RemoteConfigModel> getConfig();
}
