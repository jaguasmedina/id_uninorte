import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service.dart';
import 'package:identidaddigital/core/data/repositories/repository.dart';
import 'package:identidaddigital/core/domain/entities/faq.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/features/faqs/domain/repositories/faqs_repository.dart';

@LazySingleton(as: FaqsRepository)
class FaqsRepositoryImpl extends Repository implements FaqsRepository {
  final FaqsService faqsService;

  FaqsRepositoryImpl({
    @required this.faqsService,
  });

  @override
  Future<Either<Failure, List<Faq>>> requestFaqs() {
    return runCatching(() async {
      final faqs = await faqsService.requestFaqs();
      return Right(faqs);
    });
  }

  @override
  Future<Either<Failure, List<Faq>>> requestExternalFaqs() {
    return runCatching(() async {
      final faqs = await faqsService.requestExternalFaqs();
      return Right(faqs);
    });
  }
}
