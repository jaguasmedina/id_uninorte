import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:device_info/device_info.dart';

import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/error/exceptions.dart';

abstract class DeviceInfoDataSource {
  /// Returns the device information.
  Future<DeviceModel> requestDeviceData();
}

@LazySingleton(as: DeviceInfoDataSource)
class DeviceInfoDataSourceImpl implements DeviceInfoDataSource {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceInfoDataSourceImpl(
    this.deviceInfoPlugin,
  );

  @override
  Future<DeviceModel> requestDeviceData() async {
    DeviceModel deviceModel;
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        _validateAndroidInfo(androidInfo);
        deviceModel = DeviceModel.fromAndroidInfo(androidInfo);
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        _validateIosInfo(iosInfo);
        deviceModel = DeviceModel.fromIosInfo(iosInfo);
      }

      if (deviceModel == null) throw DeviceInfoException();

      return deviceModel;
    } catch (e) {
      throw DeviceInfoException();
    }
  }

  void _validateAndroidInfo(AndroidDeviceInfo info) {
    if (info == null) throw DeviceInfoException();

    if (info.version?.release == null ||
        info.androidId == null ||
        info.brand == null ||
        info.model == null) {
      throw DeviceInfoException();
    }
  }

  void _validateIosInfo(IosDeviceInfo info) {
    if (info == null) throw DeviceInfoException();

    if (info.systemName == null ||
        info.systemVersion == null ||
        info.identifierForVendor == null ||
        info.model == null ||
        info.name == null) {
      throw DeviceInfoException();
    }
  }
}
