import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/domain/repositories/remote_config_repository.dart';
import 'package:identidaddigital/core/domain/repositories/user_permission_repository.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;
import 'package:identidaddigital/features/digital_card/domain/repositories/digital_card_repository.dart';

@injectable
class DigitalCardBloc extends BaseBloc {
  Timer _qrTimer, _clockTimer;
  final DigitalCardRepository _digitalCardRepository;
  final UserPermissionRepository _permissionRepository;
  final RemoteConfigRepository _remoteConfigRepository;
  final ScreenBrightness _screenBrightness;

  final _qrController = BehaviorSubject<String>();

  final _clockController = StreamController<String>.broadcast();
  bool qrGenerationPaused = false;

  DigitalCardBloc(
    this._digitalCardRepository,
    this._permissionRepository,
    this._remoteConfigRepository,
    this._screenBrightness,
  ) {
    _createPeriodicClockTicker();
  }

  Stream<String> get qrStream => _qrController.stream;
  Stream<String> get clockStream => _clockController.stream;

  Future<void> startAccessCodeGeneration(User user) async {
    await _generateQR(user);
    _createPeriodicQrGeneration(user);
  }

  Future<void> regenerateQR(User user) {
    _qrController.sink.add(null);
    return _generateQR(user);
  }

  void _createPeriodicQrGeneration(User user) {
    final duration =
        Duration(milliseconds: _remoteConfigRepository.config.refreshTimeMilli);
    _qrTimer?.cancel();
    _qrTimer = Timer.periodic(
      duration,
      (timer) {
        if (qrGenerationPaused) return;
        _generateQR(user);
      },
    );
  }

  void _createPeriodicClockTicker() {
    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _tickClock();
      },
    );
  }

  Future<void> _generateQR(User user) async {
    final result = await _digitalCardRepository.requestAccessCode(user);
    result.fold(
      (failure) => _qrController.sink.addError(failure),
      (code) => _qrController.sink.add(code.data),
    );
  }

  void _tickClock() {
    final now = utils.DateFormatter.formatNow();
    _clockController.sink.add(now);
  }

  /// Returns either [Failure] or a [User] with [permission] field updated.
  Future<Either<Failure, User>> updateUserPermission() async {
    return _permissionRepository.updateUserPermission();
  }

  void turnOnScreenBrightness() {
    _screenBrightness.setScreenBrightness(1);
  }

  Future<void> preventScreenShots() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> updateQrPeriodicGenerationTimeWithRemoteConfig(User user) async {
    await _remoteConfigRepository.configure();
    _createPeriodicQrGeneration(user);
  }

  @override
  void dispose() {
    _qrTimer?.cancel();
    _clockTimer?.cancel();
    _qrController.close();
    _clockController.close();
    super.dispose();
  }
}
