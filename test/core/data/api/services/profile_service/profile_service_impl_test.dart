import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
// import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service_impl.dart';
import 'package:identidaddigital/core/data/models/models.dart';
// import 'package:identidaddigital/core/error/error.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  MockApiClient mockApiClient;
  ProfileServiceImpl profileService;
  setUp(() {
    mockApiClient = MockApiClient();
    profileService = ProfileServiceImpl(mockApiClient);
  });

  group('profile service', () {
    const userId = '1';
    const email = 'test@mail.com';
    const document = '1010';

    test(
      'should return picture status',
      () async {
        // arrange
        final Map data = json.decode(fixture('api_picture_state_empty.json'));
        final pictureStatus = PictureStatusModel.fromMap(data);
        final response = ApiResponse(
          status: ResponseStatus(code: 1, message: null),
          data: data,
        );
        when(
          mockApiClient.post<Map>(any, body: anyNamed('body')),
        ).thenAnswer((_) async => response);
        // act
        final result = await profileService.requestPictureStatus(document);
        // assert
        expect(result, equals(pictureStatus));
      },
    );

    test(
      'should return user permissions',
      () async {
        // arrange
        final Map data = json.decode(fixture('user_permission.json'));
        final userPermissionModel = UserPermissionModel.fromMap(data);
        final response = ApiResponse(
          status: ResponseStatus(code: 1, message: 'null'),
          data: data,
        );
        when(mockApiClient.getUrl<Map>(
          any,
          queryParameters: anyNamed('queryParameters'),
        )).thenAnswer((_) async => response);
        // act
        final result =
            await profileService.requestUserPermission(userId, email);
        // assert
        expect(result, equals(userPermissionModel));
      },
    );
  });
}
