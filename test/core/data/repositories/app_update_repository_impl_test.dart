import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/repositories/app_update_repository_impl.dart';

import '../../../mocks/mocks.dart';

void main() {
  AppUpdateRepositoryImpl repository;
  MockPreferencesDataSource mockPreferencesDataSource;
  MockPackageInfo mockPackageInfo;

  setUp(() {
    mockPreferencesDataSource = MockPreferencesDataSource();
    mockPackageInfo = MockPackageInfo();
    repository = AppUpdateRepositoryImpl(
      mockPreferencesDataSource,
      mockPackageInfo,
    );
  });

  group('app update repository', () {
    test(
      'should require to update when current version code is lower than the minimun required',
      () async {
        // arrange
        when(mockPreferencesDataSource.remoteConfig).thenReturn(
          const RemoteConfigModel(minVersionCode: 2),
        );
        when(mockPackageInfo.buildNumber).thenReturn('1');
        // act
        final isUpdateRequired = await repository.isUpdateRequired();
        // assert
        expect(isUpdateRequired, equals(true));
      },
    );

    test(
      'should NOT require to update when current and minimun version code are equals',
      () async {
        // arrange
        when(mockPreferencesDataSource.remoteConfig).thenReturn(
          const RemoteConfigModel(minVersionCode: 2),
        );
        when(mockPackageInfo.buildNumber).thenReturn('2');
        // act
        final isUpdateRequired = await repository.isUpdateRequired();
        // assert
        expect(isUpdateRequired, equals(false));
      },
    );

    test(
      'should NOT require to update when current version is higher than the minimun required',
      () async {
        // arrange
        when(mockPreferencesDataSource.remoteConfig).thenReturn(
          const RemoteConfigModel(minVersionCode: 2),
        );
        when(mockPackageInfo.buildNumber).thenReturn('3');
        // act
        final isUpdateRequired = await repository.isUpdateRequired();
        // assert
        expect(isUpdateRequired, equals(false));
      },
    );

    test(
      'should NOT require to update when minimun version code is NULL',
      () async {
        // arrange
        when(mockPreferencesDataSource.remoteConfig)
            .thenReturn(const RemoteConfigModel());
        when(mockPackageInfo.buildNumber).thenReturn('1');
        // act
        final isUpdateRequired = await repository.isUpdateRequired();
        // assert
        expect(isUpdateRequired, equals(false));
      },
    );

    test(
      'should NOT require to update when an Exception is thrown',
      () async {
        // arrange
        when(mockPreferencesDataSource.remoteConfig).thenThrow(Exception());
        when(mockPackageInfo.buildNumber).thenReturn('1');
        // act
        final isUpdateRequired = await repository.isUpdateRequired();
        // assert
        expect(isUpdateRequired, equals(false));
      },
    );

    test(
      'current version code must have 0 as default value',
      () async {
        // arrange
        when(mockPreferencesDataSource.remoteConfig)
            .thenReturn(const RemoteConfigModel(minVersionCode: 1));
        when(mockPackageInfo.buildNumber).thenReturn('notValidVersionCode');
        // act
        final isUpdateRequired = await repository.isUpdateRequired();
        // assert
        expect(isUpdateRequired, equals(true));
      },
    );
  });
}
