import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/constants/api_routes.dart';
import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service.dart';
import 'package:identidaddigital/core/data/models/faq_model.dart';
import 'package:identidaddigital/core/error/exceptions.dart';
import 'package:identidaddigital/core/enums/flavor.dart';

@LazySingleton(as: FaqsService)
@Environment(Env.prod)
class FaqsServiceImpl implements FaqsService {
  final ApiClient client;

  FaqsServiceImpl(this.client);

  @override
  Future<List<FaqModel>> requestFaqs() async {
    final response = await client.post<List>(
      ApiRoutes.getFaqs,
      body: <String, Object>{
        'option': 1,
      },
    );
    if (response.isSuccessful) {
      return response.data.map((dynamic e) => FaqModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FaqModel>> requestExternalFaqs() async {
    final response = await client.post<List>(
      ApiRoutes.getExternalFaqs,
      body: <String, Object>{
        'option': 2,
      },
    );
    if (response.isSuccessful) {
      return response.data.map((dynamic e) => FaqModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
