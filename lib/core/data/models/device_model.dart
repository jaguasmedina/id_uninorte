import 'package:device_info/device_info.dart';
import 'package:meta/meta.dart';
import 'package:identidaddigital/core/domain/entities/device.dart';

class DeviceModel extends Device {
  const DeviceModel({
    @required String id,
    @required String brand,
    @required String model,
    String systemName,
    String systemVersion,
  }) : super(
          id: id,
          brand: brand,
          model: model,
          systemName: systemName,
          systemVersion: systemVersion,
        );

  factory DeviceModel.fromAndroidInfo(AndroidDeviceInfo info) {
    return DeviceModel(
      id: info.androidId,
      brand: info.brand,
      model: info.model,
      systemName: 'android',
      systemVersion: info.version.release,
    );
  }

  factory DeviceModel.fromIosInfo(IosDeviceInfo info) {
    return DeviceModel(
      id: info.identifierForVendor,
      brand: info.model,
      model: info.name,
      systemName: info.systemName,
      systemVersion: info.systemVersion,
    );
  }

  Map<String, String> toMap() {
    return {
      'uid': id,
      'brand': brand,
      'model': model,
      'movilso': systemName,
      'versionso': systemVersion,
    };
  }
}
