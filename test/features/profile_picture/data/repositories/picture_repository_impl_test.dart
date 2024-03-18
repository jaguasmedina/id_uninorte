import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/features/profile_picture/data/repositories/picture_repository_impl.dart';

import '../../../../mocks/mocks.dart';

void main() {
  PictureRepositoryImpl repository;
  MockProfileService mockProfileService;
  MockPreferencesDataSource mockPreferencesDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockProfileService = MockProfileService();
    mockPreferencesDataSource = MockPreferencesDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PictureRepositoryImpl(
      mockProfileService,
      mockPreferencesDataSource,
      mockNetworkInfo,
    );
  });

  group(
    'picture repository',
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
        "should request user's current picture status",
        () async {
          // arrange
          const pictureStatusModel = PictureStatusModel('pendiente', 'mensaje');
          const PictureStatus pictureStatus = pictureStatusModel;

          when(mockProfileService.requestPictureStatus(any))
              .thenAnswer((realInvocation) async => pictureStatusModel);

          // act
          final result = await repository.requestCurrentPictureStatus();

          // assert
          const expected = Right<Failure, PictureStatus>(pictureStatus);
          verify(mockPreferencesDataSource.user);
          expect(result, equals(expected));
        },
      );

      test(
        'should upload picture',
        () async {
          // arrange

          when(mockProfileService.uploadPicture(any, any))
              .thenAnswer((_) async => null);

          // act
          final result = await repository.uploadPicture(null);

          // assert
          const expected = Right<Failure, Unit>(unit);
          verify(mockPreferencesDataSource.user);
          expect(result, equals(expected));
        },
      );
    },
  );
}
