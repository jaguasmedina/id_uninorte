import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/data_sources/device_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/features/digital_card/domain/entities/access_code.dart';
import 'package:identidaddigital/features/digital_card/domain/repositories/digital_card_repository.dart';

@LazySingleton(as: DigitalCardRepository)
class DigitalCardRepositoryImpl extends Repository
    implements DigitalCardRepository {
  final DeviceInfoDataSource deviceInfo;
  final PreferencesDataSource preferences;
  final ProfileService profileService;

  DigitalCardRepositoryImpl({
    @required this.deviceInfo,
    @required this.preferences,
    @required this.profileService,
  });

  static int _getCurrentTimeStamp() => DateTime.now().millisecondsSinceEpoch;

  @override
  Future<Device> requestDevice() async {
    final device = await deviceInfo.requestDeviceData();
    return device;
  }

  @override
  Future<Either<Failure, AccessCode>> requestAccessCode(User user) {
    return runCatching(() async {
      final qrData = await profileService.encodeAccessInfo(
        user.document,
        _getCurrentTimeStamp(),
      );
      return Right(AccessCode(qrData));
    });
  }
}
