import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/api/services/device_service/device_service_impl.dart';
import 'package:identidaddigital/core/error/error.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  MockApiClient mockApiClient;
  DeviceServiceImpl deviceService;
  setUp(() {
    mockApiClient = MockApiClient();
    deviceService = DeviceServiceImpl(mockApiClient);
  });

  group('device service', () {
    const email = 'test@mail.com';

    final response = ApiResponse<Map>.fromMap(
      json.decode(fixture('api_unlink_device_response.json')),
    );

    final unsuccessfulResponse = ApiResponse(
      status: ResponseStatus(code: -2, message: null),
      data: null,
    );

    final deviceAlreadyUnlinkedResponse = ApiResponse(
      status: ResponseStatus(code: -1, message: null),
      data: null,
    );

    test(
      'should unlink device successfully',
      () async {
        // arrange
        when(
          mockApiClient.post<Map>(any, body: anyNamed('body')),
        ).thenAnswer((_) async => response);
        // act
        final result = await deviceService.unlinkDevice(email);
        // assert
        expect(result, equals(true));
      },
    );

    test(
      "should throw DeviceAlreadyUnlinkedException if responses's status code is -1",
      () async {
        // arrange
        when(
          mockApiClient.post<Map>(any, body: anyNamed('body')),
        ).thenAnswer((_) async => deviceAlreadyUnlinkedResponse);
        // act
        final call = deviceService.unlinkDevice;
        // assert
        const expected = TypeMatcher<DeviceAlreadyUnlinkedException>();
        expect(() => call(email), throwsA(expected));
      },
    );

    test(
      'should throw ServerException if the response is not successful',
      () async {
        // arrange
        when(
          mockApiClient.post<Map>(any, body: anyNamed('body')),
        ).thenAnswer((_) async => unsuccessfulResponse);
        // act
        final call = deviceService.unlinkDevice;
        // assert
        const expected = TypeMatcher<ServerException>();
        expect(() => call(email), throwsA(expected));
      },
    );
  });
}
