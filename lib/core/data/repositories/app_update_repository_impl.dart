import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';

import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/repositories/app_update_repository.dart';

@LazySingleton(as: AppUpdateRepository)
class AppUpdateRepositoryImpl extends Repository
    implements AppUpdateRepository {
  AppUpdateRepositoryImpl(
    this._preferencesDataSource,
    this._packageInfo,
  );

  final PreferencesDataSource _preferencesDataSource;
  final PackageInfo _packageInfo;

  @override
  Future<bool> isUpdateRequired() async {
    try {
      final minVersionCode = _preferencesDataSource.remoteConfig.minVersionCode;
      final currentVersionCode = int.tryParse(_packageInfo.buildNumber) ?? 0;

      if (minVersionCode == null) return false;

      return currentVersionCode < minVersionCode;
    } catch (e) {
      return false;
    }
  }
}
