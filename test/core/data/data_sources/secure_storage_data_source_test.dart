import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import 'package:identidaddigital/core/data/data_sources/secure_storage_data_source.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/error.dart';

import '../../../mocks/mocks.dart';

void main() {
  SecureStorageDataSourceImpl dataSource;
  MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    dataSource = SecureStorageDataSourceImpl(mockFlutterSecureStorage);
  });

  const tUsername = 'user';
  const tPassword = 'pass';
  final tCredentials = AuthCredentials(
    username: tUsername,
    password: tPassword,
  );

  group('secure storage', () {
    group('read last credentials', () {
      test(
        'should return AuthCredentials when there is stored data',
        () async {
          // arrange
          when(mockFlutterSecureStorage.read(key: anyNamed('key')))
              .thenAnswer((_) async => tPassword);
          // act
          final result = await dataSource.requestCredentials();
          // assert
          expect(result.username, equals(tCredentials.password));
          expect(result.password, equals(tCredentials.password));
        },
      );
      test(
        'should throw a CredentialsNotFoundException when there is no stored data',
        () async {
          // arrange
          when(mockFlutterSecureStorage.read(key: anyNamed('key')))
              .thenAnswer((_) async => null);
          // act
          final call = dataSource.requestCredentials;
          // assert
          expect(() => call(),
              throwsA(const TypeMatcher<CredentialsNotFoundException>()));
        },
      );
    });

    group('store last credentials', () {
      test(
        'should call secure storage and store the data',
        () async {
          // act
          await dataSource.storeCredentials(tCredentials);
          // assert

          verify(mockFlutterSecureStorage.write(
            key: anyNamed('key'),
            value: tCredentials.username,
          ));
          verify(mockFlutterSecureStorage.write(
            key: anyNamed('key'),
            value: tCredentials.password,
          ));
        },
      );
    });
  });
}
