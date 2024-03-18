import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  group('user permission model', () {
    const userPermissionModel = UserPermissionModel(
      id: "200010101",
      name: "TEST NAME",
      document: "10101010",
      picture: "image",
      profiles: [
        UserProfileModel(name: 'EG', title: 'Egresado', colorHexStr: 'E0AF28'),
      ],
    );

    final Map<String, dynamic> userPermissionMap =
        json.decode(fixture('user_permission.json'));

    test(
      'should be a subclass of user permission entity',
      () {
        // assert
        expect(userPermissionModel, isA<UserPermission>());
      },
    );

    group('fromMap', () {
      test(
        'should return a valid model',
        () {
          // act
          final result = UserPermissionModel.fromMap(userPermissionMap);
          // assert
          expect(result, equals(userPermissionModel));
        },
      );
    });

    group('toMap', () {
      test(
        'should return a map containing the proper data',
        () {
          // act
          final result = userPermissionModel.toMap();
          // assert
          expect(result, equals(userPermissionMap));
        },
      );
    });
  });
}
