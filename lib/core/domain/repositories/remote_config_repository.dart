import 'package:identidaddigital/core/domain/entities/entities.dart';

abstract class RemoteConfigRepository {
  /// Remote config values.
  RemoteConfig get config;

  /// Configure values from remote database.
  Future<void> configure();
}
