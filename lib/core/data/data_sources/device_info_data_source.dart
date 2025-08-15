import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

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
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        _validateAndroidInfo(androidInfo);
        return DeviceModel.fromAndroidInfo(androidInfo);
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        _validateIosInfo(iosInfo);
        return DeviceModel.fromIosInfo(iosInfo);
      } else {
        throw DeviceInfoException();
      }
    } catch (_) {
      throw DeviceInfoException();
    }
  }

  void _validateAndroidInfo(AndroidDeviceInfo info) {
    if (info.version.release?.isEmpty == true ||
        info.id?.isEmpty == true ||
        info.brand?.isEmpty == true ||
        info.model?.isEmpty == true) {
      throw DeviceInfoException();
    }
  }

  void _validateIosInfo(IosDeviceInfo info) {
    if (info.systemName?.isEmpty == true ||
        info.systemVersion?.isEmpty == true ||
        info.identifierForVendor?.isEmpty == true ||
        info.model?.isEmpty == true ||
        info.name?.isEmpty == true) {
      throw DeviceInfoException();
    }
  }
}
