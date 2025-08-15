import 'package:identidaddigital/core/domain/entities/entities.dart';

class RemoteConfigModel extends RemoteConfig {
  const RemoteConfigModel({
    int? refreshTimeMilli,
    int? minVersionCode,
  }) : super(
          refreshTimeMilli: refreshTimeMilli ?? 30000,
          minVersionCode: minVersionCode ?? 0,
        );

  factory RemoteConfigModel.fromMap(Map map) {
    return RemoteConfigModel(
      refreshTimeMilli: map['refresh_time_milli'],
      minVersionCode: map['min_version_code'],
    );
  }

  factory RemoteConfigModel.initial() {
    return const RemoteConfigModel(
      refreshTimeMilli: 30000,
    );
  }

  Map<String, Object> toMap() {
    return {
      'refresh_time_milli': refreshTimeMilli,
      'min_version_code': minVersionCode ?? 0,
    };
  }
}
