import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class PackageInfoDataSource {
  String get version;
}

@LazySingleton(as: PackageInfoDataSource)
class PackageInfoDataSourceImpl implements PackageInfoDataSource {
  final PackageInfo packageInfo;

  PackageInfoDataSourceImpl(this.packageInfo);

  @override
  String get version {
    return packageInfo.version;
  }
}
