import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/navigation/destinations.dart';
import 'package:identidaddigital/core/data/repositories/destination_repository_impl.dart';

import '../../../mocks/mocks.dart';

void main() {
  DestinationRepositoryImpl repository;
  MockPreferencesDataSource mockPreferencesDataSource;

  setUp(() {
    mockPreferencesDataSource = MockPreferencesDataSource();
    repository = DestinationRepositoryImpl(mockPreferencesDataSource);
  });

  group('destination repository', () {
    final currentTimestamp = Timestamp.now();
    const int diff = 6 * 60 * 60 * 24;
    final expiredTimestamp = Timestamp(currentTimestamp.seconds - diff);

    const noPermissionUserModel = UserModel(
      deviceUID: 'cay447fhf7',
      deviceBrand: 'test brand',
      deviceModel: 'test model',
      emailExt: 'ext@test.com',
      emailUN: 'un@un.com',
      lastAccess: '',
      permission: null,
    );

    final completeUserModel = noPermissionUserModel.copyModel(
      permission: const UserPermissionModel(
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

    group('requestInitialDestination', () {
      setUp(() {
        when(mockPreferencesDataSource.onboardingDidShow).thenReturn(false);
        when(mockPreferencesDataSource.permissionsLastUpdatedTime)
            .thenReturn(currentTimestamp);
      });

      test(
        'should return onboarding route when orboarding has not been shown',
        () {
          // arrange
          when(mockPreferencesDataSource.user).thenReturn(null);
          // act
          final destination = repository.requestInitialDestination();
          // assert
          expect(destination, equals(Destinations.onboarding));
          verifyNever(mockPreferencesDataSource.clearUserData());
        },
      );
    });

    group('requestOnboardingDestination', () {
      setUp(() {
        when(mockPreferencesDataSource.onboardingDidShow).thenReturn(true);
        when(mockPreferencesDataSource.permissionsLastUpdatedTime)
            .thenReturn(currentTimestamp);
      });
      test(
        'should return login route when user is null',
        () {
          // arrange
          when(mockPreferencesDataSource.user).thenReturn(null);
          // act
          final destination = repository.requestOnboardingDestination();
          // assert
          expect(destination, equals(Destinations.login));
          verify(mockPreferencesDataSource.clearUserData());
        },
      );

      test(
        "should return login route when user doesn't have enough data to create a carnet",
        () {
          // arrange
          when(mockPreferencesDataSource.user)
              .thenReturn(noPermissionUserModel);
          // act
          final destination = repository.requestOnboardingDestination();
          // assert
          expect(destination, equals(Destinations.login));
          verify(mockPreferencesDataSource.clearUserData());
        },
      );

      test(
        "should return login route when user permission last updated time has expired",
        () {
          // arrange
          when(mockPreferencesDataSource.user).thenReturn(completeUserModel);
          when(
            mockPreferencesDataSource.permissionsLastUpdatedTime,
          ).thenReturn(expiredTimestamp);

          // act
          final destination = repository.requestOnboardingDestination();
          // assert
          expect(destination, equals(Destinations.login));
          verify(mockPreferencesDataSource.clearUserData());
        },
      );
      test(
        "should return carnet route when user can create carnet and permission last updated time hasn't expired",
        () {
          // arrange
          when(mockPreferencesDataSource.user).thenReturn(completeUserModel);
          when(
            mockPreferencesDataSource.permissionsLastUpdatedTime,
          ).thenReturn(currentTimestamp);

          // act
          final destination = repository.requestOnboardingDestination();
          // assert
          expect(destination, equals(Destinations.carnet));
          verifyNever(mockPreferencesDataSource.clearUserData());
        },
      );
    });

    test(
      'should save that onboarding was shown',
      () {
        // act
        repository.saveOnboardingDidShow();
        // assert
        verify(mockPreferencesDataSource.onboardingDidShow = true);
      },
    );
  });
}
