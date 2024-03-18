import 'package:flutter_test/flutter_test.dart';

import 'package:identidaddigital/features/digital_card/utils/access_code_converter.dart';

void main() {
  group('access code converter', () {
    const params = <String>['device_id', 'user_id', 'current_timestamp'];
    const expectedData = 'ZGV2aWNlX2lkLi91c2VyX2lkLi9jdXJyZW50X3RpbWVzdGFtcA==';
    test(
      'should encode the given list of params properly',
      () {
        // act
        final result = AccessCodeConverter.encode(params);
        //assert
        expect(result, equals(expectedData));
      },
    );
  });
}
