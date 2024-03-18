import 'package:identidaddigital/core/data/models/faq_model.dart';

abstract class FaqsService {
  // Returns a list of frequently asked questions.
  Future<List<FaqModel>> requestFaqs();

  // Returns a list of frequently asked questions without authentication
  Future<List<FaqModel>> requestExternalFaqs();
}
