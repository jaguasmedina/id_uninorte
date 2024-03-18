import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/models/faq_model.dart';
import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service_impl.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  MockApiClient mockApiClient;
  FaqsServiceImpl faqsService;

  setUp(() {
    mockApiClient = MockApiClient();
    faqsService = FaqsServiceImpl(mockApiClient);
  });

  group("FAQ's service", () {
    final jsonRes = fixture('faqs_response.json');
    final response = ApiResponse<List>.fromMap(jsonDecode(jsonRes));
    final faqModelList = List<FaqModel>.from(
      response.data.map<FaqModel>((dynamic e) => FaqModel.fromMap(e)),
    );

    test(
      'should return list of FaqModel',
      () async {
        when(
          mockApiClient.post<List>(any, body: anyNamed('body')),
        ).thenAnswer((_) async => response);

        final result = await faqsService.requestFaqs();

        expect(result, equals(faqModelList));
      },
    );
  });
}
