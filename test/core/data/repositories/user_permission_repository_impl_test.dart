import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/repositories/user_permission_repository_impl.dart';
import 'package:identidaddigital/core/error/error.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../mocks/mocks.dart';

void main() {
  UserPermissionRepositoryImpl repository;
  MockProfileService mockProfileService;
  MockPreferencesDataSource mockPreferencesDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockProfileService = MockProfileService();
    mockPreferencesDataSource = MockPreferencesDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserPermissionRepositoryImpl(
      mockProfileService,
      mockPreferencesDataSource,
      mockNetworkInfo,
    );
  });

  group('user permission repository', () {
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

    final Map userPermissionData = json.decode(fixture('user_permission.json'));

    final userPermissionModel = UserPermissionModel.fromMap(userPermissionData);

    final currentTimestamp = Timestamp.now();
    const int diff = 6 * 60 * 60 * 24;
    final expiredTimestamp = Timestamp(currentTimestamp.seconds - diff);

    setUp(() {
      when(mockNetworkInfo.ensureConnection()).thenAnswer((_) async => null);
      when(mockPreferencesDataSource.user).thenReturn(userModel);
      when(mockPreferencesDataSource.permissionsLastUpdatedTime)
          .thenReturn(currentTimestamp);
    });

    test(
      'should request permissions and return the updated user',
      () async {
        // arrange
        when(mockProfileService.requestUserPermission(any, any))
            .thenAnswer((_) async => userPermissionModel);
        // act
        final result = await repository.updateUserPermission();
        // assert
        final expectedUser =
            userModel.copyModel(permission: userPermissionModel);
        final expectedResult = Right<Failure, User>(expectedUser);
        expect(result, equals(expectedResult));
        verify(mockPreferencesDataSource.user = expectedUser);
      },
    );

    test(
      'should return PermissionNotFoundFailure and clear preferences when PermissionNotFoundException is thrown',
      () async {
        // arrange
        when(mockProfileService.requestUserPermission(any, any))
            .thenThrow(PermissionNotFoundException());
        // act
        final result = await repository.updateUserPermission();
        // assert
        final expectedResult = Left<Failure, User>(PermissionNotFoundFailure());
        expect(result, equals(expectedResult));
        verify(mockPreferencesDataSource.clearUserData()).called(1);
      },
    );

    test(
      'should return PermissionNotFoundFailure and clear preferences when SessionExpiredException is thrown',
      () async {
        // arrange
        when(mockProfileService.requestUserPermission(any, any))
            .thenThrow(SessionExpiredException());
        // act
        final result = await repository.updateUserPermission();
        // assert
        final expectedResult = Left<Failure, User>(PermissionNotFoundFailure());
        expect(result, equals(expectedResult));
        verify(mockPreferencesDataSource.clearUserData()).called(1);
      },
    );

    test(
      'should return PermissionNotFoundFailure and clear preferences when an AppException is thrown and user permission last updated time has expired',
      () async {
        // arrange
        when(mockProfileService.requestUserPermission(any, any))
            .thenThrow(ServerException());
        when(mockPreferencesDataSource.permissionsLastUpdatedTime)
            .thenReturn(expiredTimestamp);
        // act
        final result = await repository.updateUserPermission();
        // assert
        final expectedResult = Left<Failure, User>(PermissionNotFoundFailure());
        expect(result, equals(expectedResult));
        verify(mockPreferencesDataSource.clearUserData());
      },
    );

    test(
      "should return Failure when an AppException is thrown and user permission last updated time hasn't expired",
      () async {
        // arrange
        when(mockProfileService.requestUserPermission(any, any))
            .thenThrow(UnexpectedException());
        when(mockPreferencesDataSource.permissionsLastUpdatedTime)
            .thenReturn(currentTimestamp);
        // act
        final result = await repository.updateUserPermission();
        // assert
        expect(result, isA<Left<Failure, User>>());
        verifyNever(mockPreferencesDataSource.clearUserData());
      },
    );
  });
}
