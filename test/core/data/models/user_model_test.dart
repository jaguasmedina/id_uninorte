import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/data/models/user_profile_model.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    deviceUID: '123456',
    deviceBrand: 'google',
    deviceModel: 'AOSP on IA Emulator',
    emailExt: 'medm89@gmail.com',
    emailUN: null,
    permission: UserPermissionModel(
      id: '200013284',
      name: 'MARTIN EMILIO DIAZ MORA',
      document: '1140819289',
      picture: 'image/png;base64',
      profiles: [
        UserProfileModel(name: 'EG', title: 'Egresado', colorHexStr: 'E0AF28'),
      ],
    ),
  );

  group('user model', () {
    test(
      'should be a subclass of user entity',
      () {
        // assert
        expect(tUserModel, isA<User>());
      },
    );

    group('fromMap', () {
      test(
        'should return a valid model',
        () {
          // arrange
          final Map<String, dynamic> map = json.decode(fixture('user.json'));
          // act
          final result = UserModel.fromMap(map);
          // assert
          expect(result, equals(tUserModel));
        },
      );
    });

    group('toMap', () {
      test(
        'should return a map containing the proper data',
        () {
          // arrange
          final map = <String, dynamic>{
            'registerPhone': {
              'data': {
                'user_email_un': tUserModel.emailUN,
                'user_email_ext': tUserModel.emailExt,
                'user_uid': tUserModel.deviceUID,
                'user_phone_model': tUserModel.deviceModel,
                'user_phone_brand': tUserModel.deviceBrand,
                'user_last_access': tUserModel.lastAccess,
              }
            },
            'permission': {
              'data': {
                'id': tUserModel.id,
                'documento': tUserModel.document,
                'nombre': tUserModel.name,
                'foto': tUserModel.picture,
                'perfilesnew': tUserModel.permission.profiles
                    .map((e) => e.toMap())
                    .toList(),
              }
            },
          };
          // act
          final result = tUserModel.toMap();
          // assert
          expect(result, equals(map));
        },
      );
    });
  });
}
