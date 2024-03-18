import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/domain/entities/device.dart';
import 'package:identidaddigital/core/domain/entities/user.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/features/digital_card/domain/entities/access_code.dart';

abstract class DigitalCardRepository {
  /// Request device data.
  Future<Device> requestDevice();

  /// Returns a valid access code.
  Future<Either<Failure, AccessCode>> requestAccessCode(User user);
}
