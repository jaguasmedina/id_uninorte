import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/api/request/login_request.dart';
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service_impl.dart';
import 'package:identidaddigital/core/data/models/models.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  AuthServiceImpl authService;
  MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    authService = AuthServiceImpl(mockApiClient);
  });

  group('auth service', () {
    final tRequest = LoginRequest(
      credentials: AuthCredentialsModel(
        username: 'user@email.co',
        password: 'test',
      ),
      device: const DeviceModel(
        id: 'test uid',
        brand: 'test brand',
        model: 'test model',
        systemName: 'test',
        systemVersion: '0.0.1',
      ),
    );

    final tApiResponse = ApiResponse<Map>.fromMap(
      json.decode(fixture('api_login_response.json')),
    );

    final tUserModel = UserModel.fromMap(
      json.decode(fixture('user.json')),
    );
    test(
      'should returns user model when the call to Api is successful',
      () async {
        // arrange
        when(mockApiClient.post<Map>(any, body: anyNamed('body'))).thenAnswer(
          (_) async => tApiResponse,
        );
        // act
        final result = await authService.login(tRequest);
        // assert
        expect(result.value1, equals(tUserModel));
      },
    );

    test(
      'should throw an Exception when the call to Api is unsuccessful',
      () async {
        // arrange
        when(mockApiClient.post<Map>(any, body: anyNamed('body')))
            .thenAnswer((_) async => null);
        // act
        final call = authService.login;
        // assert
        expect(() => call(tRequest), throwsA(const TypeMatcher<dynamic>()));
      },
    );

    test(
      "should throw DeviceAlreadyInUseException when the reponse's status code is -1",
      () async {
        // arrange
        final response = ApiResponse(
          data: null,
          status: ResponseStatus(code: -1, message: 'message'),
        );
        when(mockApiClient.post<Map>(any, body: anyNamed('body')))
            .thenAnswer((_) async => response);
        // act
        final call = authService.login;
        // assert
        const expected = TypeMatcher<DeviceAlreadyInUseException>();
        expect(() => call(tRequest), throwsA(expected));
      },
    );

    test(
      "should throw NotAuthorizedException when the reponse's status code is 401",
      () async {
        // arrange
        final response = ApiResponse(
          data: null,
          status: ResponseStatus(code: 401, message: 'message'),
        );
        when(mockApiClient.post<Map>(any, body: anyNamed('body')))
            .thenAnswer((_) async => response);
        // act
        final call = authService.login;
        // assert
        const expected = TypeMatcher<NotAuthorizedException>();
        expect(() => call(tRequest), throwsA(expected));
      },
    );
  });
}
