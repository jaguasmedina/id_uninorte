import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/constants/api_routes.dart';
import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart';
import 'package:identidaddigital/core/enums/flavor.dart';
import 'package:identidaddigital/core/error/exceptions.dart';

@LazySingleton(as: DeviceService)
@Environment(Env.prod)
class DeviceServiceImpl implements DeviceService {
  final ApiClient client;

  DeviceServiceImpl(this.client);

  @override
  Future<bool> unlinkDevice(String email) async {
    final response = await client.post<Map>(
      ApiRoutes.unlinkDevice,
      body: <String, String>{'email': email},
    );
    if (response.isSuccessful) {
      return true;
    } else if (response.status.code == -1) {
      throw DeviceAlreadyUnlinkedException();
    } else {
      throw ServerException();
    }
  }
}
