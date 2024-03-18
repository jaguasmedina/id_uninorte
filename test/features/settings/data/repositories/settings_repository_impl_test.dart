import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/features/settings/data/repositories/settings_repository_impl.dart';

import '../../../../mocks/mocks.dart';

void main() {
  SettingsRepositoryImpl repository;
  MockPreferencesDataSource mockPreferencesDataSource;
  MockNetworkInfo mockNetworkInfo;
  MockBiometricsDataSource mockBiometricsDataSource;
  MockSecureStorageDataSource mockSecureStorageDataSource;
  MockDeviceService mockDeviceService;
  MockProfileService mockProfileService;
  MockPackageInfoDataSource mockPackageInfoDataSource;

  setUp(() {
    mockPreferencesDataSource = MockPreferencesDataSource();
    mockBiometricsDataSource = MockBiometricsDataSource();
    mockSecureStorageDataSource = MockSecureStorageDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockPackageInfoDataSource = MockPackageInfoDataSource();
    mockDeviceService = MockDeviceService();
    mockProfileService = MockProfileService();
    repository = SettingsRepositoryImpl(
      packageInfo: mockPackageInfoDataSource,
      preferences: mockPreferencesDataSource,
      biometrics: mockBiometricsDataSource,
      deviceService: mockDeviceService,
      profileService: mockProfileService,
      networkInfo: mockNetworkInfo,
      secureStorage: mockSecureStorageDataSource,
    );
  });

  group(
    'settings repository',
    () {
      const userModel = UserModel(
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

      setUp(() {
        when(mockNetworkInfo.ensureConnection()).thenAnswer((_) => null);
        when(mockPreferencesDataSource.user).thenReturn(userModel);
      });

      test(
        'should unlink device and clear all user data',
        () async {
          // arrange
          when(mockDeviceService.unlinkDevice(any)).thenAnswer((_) => null);
          // act
          final result = await repository.unlinkDevice();
          //assert
          const expected = Right<Failure, Unit>(unit);
          expect(result, equals(expected));
          verify(mockSecureStorageDataSource.deleteCredentials());
          verify(mockPreferencesDataSource.clearUserData());
        },
      );

      test(
        'should clear user data an logout if DeviceAlreadyUnlinkedException is thrown',
        () async {
          // arrange
          when(mockDeviceService.unlinkDevice(any))
              .thenThrow(DeviceAlreadyUnlinkedException());
          // act
          final result = await repository.unlinkDevice();
          //assert
          final expected = Left<Failure, Unit>(DeviceAlreadyUnlinkedFailure());
          expect(result, equals(expected));
          verify(mockSecureStorageDataSource.deleteCredentials());
          verify(mockPreferencesDataSource.clearUserData());
        },
      );

      test(
        'should clear preferences when logging out',
        () async {
          // arrange
          when(mockPreferencesDataSource.clearUserData())
              .thenAnswer((_) => null);
          // act
          await repository.logout();
          //assert
          verify(mockPreferencesDataSource.clearUserData());
        },
      );

      test(
        'should verify if biometrics are available',
        () async {
          // arrange
          const biometricsResponse = true;
          when(mockBiometricsDataSource.areBiometricsAvailable())
              .thenAnswer((_) async => biometricsResponse);
          // act
          final result = await repository.areBiometricsAvailable();
          //assert
          expect(result, biometricsResponse);
          verify(mockBiometricsDataSource.areBiometricsAvailable()).called(1);
        },
      );

      test(
        'should request app version from package info data source',
        () {
          // arrange
          const appVersion = '0.0.0';
          when(mockPackageInfoDataSource.version).thenReturn(appVersion);
          // act
          final result = repository.appVersion;
          //assert
          expect(result, appVersion);
          verify(mockPackageInfoDataSource.version);
        },
      );

      test(
        'should request whether access with biometrics are enabled from preferences',
        () {
          // arrange
          const enabled = true;
          when(mockPreferencesDataSource.biometricAccessEnabled)
              .thenReturn(enabled);
          // act
          final result = repository.biometricAccessEnabled;
          //assert
          expect(result, enabled);
          verify(mockPreferencesDataSource.biometricAccessEnabled);
        },
      );

      test(
        'should store whether access with biometrics are enabled in preferences',
        () {
          // arrange
          const enabled = true;
          // act
          repository.biometricAccessEnabled = enabled;
          //assert
          verify(mockPreferencesDataSource.biometricAccessEnabled = enabled);
        },
      );
    },
  );
}
