import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart';
import 'package:identidaddigital/core/enums/flavor.dart';

@LazySingleton(as: DeviceService)
@Environment(Env.dev)
class DevDeviceServiceImpl implements DeviceService {
  @override
  Future<bool> unlinkDevice(String email) async {
    return true;
  }
}
