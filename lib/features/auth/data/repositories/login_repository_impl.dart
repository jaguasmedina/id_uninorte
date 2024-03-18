import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/analytics/analytics.dart';
import 'package:identidaddigital/core/data/api/request/login_request.dart';
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service.dart';
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/data_sources/biometrics_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/device_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/secure_storage_data_source.dart';
import 'package:identidaddigital/core/data/models/auth_credentials_model.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/features/auth/domain/repositories/login_repository.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl extends Repository implements LoginRepository {
  final AuthService authService;
  final ProfileService profileService;
  final SecureStorageDataSource secureStorage;
  final BiometricsDataSource biometrics;
  final PreferencesDataSource preferences;
  final NetworkInfoDataSource networkInfo;
  final DeviceInfoDataSource deviceInfo;
  final AnalyticsLogger analyticsLogger;

  LoginRepositoryImpl({
    @required this.authService,
    @required this.profileService,
    @required this.secureStorage,
    @required this.biometrics,
    @required this.preferences,
    @required this.networkInfo,
    @required this.deviceInfo,
    @required this.analyticsLogger,
  });

  @override
  Future<Either<Failure, User>> login(AuthCredentials credentials) {
    return runCatching(() async {
      await networkInfo.ensureConnection();
      AuthCredentials authCredentials = credentials;
      if (!credentials.hasValidEmailAsUsername) {
        authCredentials = credentials.concatToUsername('@uninorte.edu.co');
      }

      final device = await deviceInfo.requestDeviceData();
      final request = LoginRequest(
        credentials: AuthCredentialsModel.fromEntity(authCredentials),
        device: device,
      );

      analyticsLogger.logEvent(LoginAttempt(authCredentials.username));
      final data = await authService.login(request);

      final userModel = data.value1;
      final authToken = data.value2;
      preferences.user = userModel;

      preferences.authToken = authToken;
      if (!userModel.hasPermission) {
        return Left(PermissionNotFoundFailure());
      }
      if (!userModel.canCreateCarnet) {
        return Left(PictureNotFoundFailure());
      }
      await secureStorage.storeCredentials(credentials);
      return Right(userModel);
    });
  }

  @override
  Future<bool> authenticateWithBiometrics(
    AppLocalizations localizations,
  ) async {
    try {
      final authenticated = await biometrics.authenticate(localizations);
      return authenticated;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> areBiometricsAvailable() async {
    try {
      final hasBiometrics = await biometrics.areBiometricsAvailable();
      return hasBiometrics && preferences.biometricAccessEnabled;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, AuthCredentials>> requestCredentials() {
    return runCatching(() async {
      final credentials = await secureStorage.requestCredentials();
      return Right(credentials);
    });
  }

  @override
  Future<Either<Failure, Unit>> changePasswordForExternalUser(
      AuthCredentials credentials) {
    return runCatching(() async {
      await networkInfo.ensureConnection();
      await profileService.changePasswordForExternalUser(
        AuthCredentialsModel.fromEntity(credentials),
      );
      await secureStorage.storeCredentials(credentials);
      return const Right(unit);
    });
  }
}
