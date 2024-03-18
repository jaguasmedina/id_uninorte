import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart';
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/data_sources/biometrics_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/secure_storage_data_source.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/features/settings/data/data_sources/package_info_data_source.dart';
import 'package:identidaddigital/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends Repository implements SettingsRepository {
  final PackageInfoDataSource packageInfo;
  final PreferencesDataSource preferences;
  final BiometricsDataSource biometrics;
  final DeviceService deviceService;
  final ProfileService profileService;
  final NetworkInfoDataSource networkInfo;
  final SecureStorageDataSource secureStorage;

  SettingsRepositoryImpl({
    @required this.packageInfo,
    @required this.preferences,
    @required this.biometrics,
    @required this.deviceService,
    @required this.profileService,
    @required this.networkInfo,
    @required this.secureStorage,
  });

  @override
  String get appVersion => packageInfo.version;

  @override
  bool get biometricAccessEnabled => preferences.biometricAccessEnabled;

  @override
  set biometricAccessEnabled(bool value) {
    preferences.biometricAccessEnabled = value;
  }

  @override
  Future<bool> areBiometricsAvailable() async {
    try {
      final hasBiometrics = await biometrics.areBiometricsAvailable();
      return hasBiometrics;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, Unit>> unlinkDevice() {
    return runCatching(() async {
      try {
        await networkInfo.ensureConnection();
        final email = preferences.userEmail ?? preferences.user.currentEmail;
        await deviceService.unlinkDevice(email);
        await secureStorage.deleteCredentials();
        await logout();
        return const Right(unit);
      } on DeviceAlreadyUnlinkedException catch (e) {
        await secureStorage.deleteCredentials();
        await logout();
        return Left(e.toFailure());
      }
    });
  }

  @override
  Future<void> logout() async {
    return preferences.clearUserData();
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(Message message) {
    return runCatching(() async {
      await networkInfo.ensureConnection();
      await profileService.sendMessageToContactCenter(
        MessageModel.fromEntity(message),
      );
      return const Right(unit);
    });
  }
}
