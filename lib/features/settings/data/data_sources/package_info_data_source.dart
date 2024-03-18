import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';

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
