import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/analytics/analytics.dart';
import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/data/api/request/login_request.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/features/auth/data/repositories/login_repository_impl.dart';

import '../../../../mocks/mocks.dart';

void main() {
  LoginRepositoryImpl repository;
  MockBiometricsDataSource mockBiometricsDataSource;
  MockAuthService mockAuthService;
  MockProfileService mockProfileService;
  MockSecureStorageDataSource mockSecureStorageDataSource;
  MockPreferencesDataSource mockPreferencesDataSource;
  MockNetworkInfo mockNetworkInfo;
  MockDeviceInfo mockDeviceInfo;
  MockAnalyticsLogger mockAnalyticsLogger;
  setUp(() {
    mockBiometricsDataSource = MockBiometricsDataSource();
    mockAuthService = MockAuthService();
    mockProfileService = MockProfileService();
    mockSecureStorageDataSource = MockSecureStorageDataSource();
    mockPreferencesDataSource = MockPreferencesDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockDeviceInfo = MockDeviceInfo();
    mockAnalyticsLogger = MockAnalyticsLogger();
    repository = LoginRepositoryImpl(
      biometrics: mockBiometricsDataSource,
      authService: mockAuthService,
      profileService: mockProfileService,
      secureStorage: mockSecureStorageDataSource,
      preferences: mockPreferencesDataSource,
      networkInfo: mockNetworkInfo,
      deviceInfo: mockDeviceInfo,
      analyticsLogger: mockAnalyticsLogger,
    );
  });

  const tDevice = DeviceModel(
    id: 'test uid',
    brand: 'test brand',
    model: 'test model',
    systemName: 'test',
    systemVersion: '0.0.1',
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.ensureConnection()).thenAnswer((_) async {});
        when(mockDeviceInfo.requestDeviceData())
            .thenAnswer((_) async => tDevice);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.ensureConnection()).thenThrow(NetworkException());
      });

      body();
    });
  }

  group('login repository', () {
    final credentialsWithEmail = AuthCredentials(
      username: 'user@email.co',
      password: 'emailpass',
    );

    final tLoginRequest = LoginRequest(
      credentials: AuthCredentialsModel.fromEntity(credentialsWithEmail),
      device: tDevice,
    );

    const tUserModel = UserModel(
      deviceUID: 'cay447fhf7',
      deviceBrand: 'test brand',
      deviceModel: 'test model',
      emailExt: 'ext@test.com',
      emailUN: 'un@un.com',
      permission: UserPermissionModel(
        id: '20009990',
        name: 'Test Foo Bar',
        document: '1102928',
        picture: 'image',
        profiles: [
          UserProfileModel(
              name: 'EG', title: 'Egresado', colorHexStr: 'E0AF28'),
        ],
      ),
    );

    final tTuple2 = tuple2(tUserModel, 'accesstoken');

    const User tUser = tUserModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.ensureConnection()).thenAnswer((_) async => true);
        // act
        repository.login(credentialsWithEmail);
        // assert
        verify(mockNetworkInfo.ensureConnection());
      },
    );

    runTestsOnline(() {
      test(
        'should add the corresponding value to the credentials when the username is not an email',
        () async {
          // arange
          final credentialsWithAlias = AuthCredentials(
            username: 'tuser',
            password: 'aliaspass',
          );
          final transformedCredentials = credentialsWithAlias.concatToUsername(
            '@uninorte.edu.co',
          );
          final request = LoginRequest(
            credentials:
                AuthCredentialsModel.fromEntity(transformedCredentials),
            device: tDevice,
          );
          when(mockDeviceInfo.requestDeviceData())
              .thenAnswer((_) async => tDevice);
          // act
          await repository.login(credentialsWithAlias);
          // assert
          verify(mockAuthService.login(request));
        },
      );

      test(
        'should return user data when the call to api data source is successful',
        () async {
          // arrange
          when(mockAuthService.login(any)).thenAnswer((_) async => tTuple2);

          // act
          final result = await repository.login(credentialsWithEmail);
          // assert
          verify(mockAuthService.login(tLoginRequest));
          verify(mockAnalyticsLogger
              .logEvent(LoginAttempt(credentialsWithEmail.username)));
          expect(result, const Right<dynamic, User>(tUser));
        },
      );

      test(
        'should store user data and auth token when the call to api data source is successful',
        () async {
          // arrange
          when(mockAuthService.login(any)).thenAnswer((_) async => tTuple2);

          // act
          await repository.login(credentialsWithEmail);
          // assert
          verify(mockAuthService.login(tLoginRequest));
          verify(mockPreferencesDataSource.user = tTuple2.value1);
          verify(mockPreferencesDataSource.authToken = tTuple2.value2);
          verify(mockSecureStorageDataSource
              .storeCredentials(credentialsWithEmail));
        },
      );

      test(
        'should return PermissionNotFoundFailure when user.permission field is null',
        () async {
          // arrange
          const userModelWithNoPermission = UserModel(
            deviceUID: 'cay447fhf7',
            deviceBrand: 'test brand',
            deviceModel: 'test model',
            emailExt: 'ext@test.com',
            emailUN: 'un@un.com',
            permission: null,
          );

          final loginResponse = tuple2(
            userModelWithNoPermission,
            'accesstoken',
          );

          when(mockAuthService.login(any))
              .thenAnswer((_) async => loginResponse);

          // act
          final result = await repository.login(credentialsWithEmail);

          // assert
          expect(
            result,
            equals(Left<Failure, Object>(PermissionNotFoundFailure())),
          );
          verifyZeroInteractions(mockSecureStorageDataSource);
        },
      );

      test(
        "should return PictureNotFoundFailure when user doesn't have a picture",
        () async {
          // arrange
          const userModelWithNoPicture = UserModel(
            deviceUID: 'cay447fhf7',
            deviceBrand: 'test brand',
            deviceModel: 'test model',
            emailExt: 'ext@test.com',
            emailUN: 'un@un.com',
            permission: UserPermissionModel(
              id: '20009990',
              name: 'Test Foo Bar',
              document: '1102928',
              picture: null,
              profiles: [
                UserProfileModel(
                    name: 'EG', title: 'Egresado', colorHexStr: 'E0AF28'),
              ],
            ),
          );

          final loginResponse = tuple2(
            userModelWithNoPicture,
            'accesstoken',
          );

          when(mockAuthService.login(any))
              .thenAnswer((_) async => loginResponse);

          // act
          final result = await repository.login(credentialsWithEmail);

          // assert
          expect(
            result,
            equals(Left<Failure, Object>(PictureNotFoundFailure())),
          );
          verifyZeroInteractions(mockSecureStorageDataSource);
        },
      );

      test(
        'should return server failure when the call to api data source is unsuccessful',
        () async {
          // arrange
          when(mockAuthService.login(any)).thenThrow(ServerException());

          // act
          final result = await repository.login(credentialsWithEmail);
          // assert
          verify(mockAuthService.login(tLoginRequest));
          verifyZeroInteractions(mockSecureStorageDataSource);
          verifyZeroInteractions(mockPreferencesDataSource);
          expect(result, Left<Failure, User>(ServerFailure()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return network failure',
        () async {
          // arrange
          // act
          final result = await repository.login(credentialsWithEmail);
          // assert
          verifyZeroInteractions(mockDeviceInfo);
          verifyZeroInteractions(mockAuthService);
          verifyZeroInteractions(mockSecureStorageDataSource);
          verifyZeroInteractions(mockPreferencesDataSource);
          expect(result, Left<Failure, User>(NetworkFailure()));
        },
      );
    });
  });
}
