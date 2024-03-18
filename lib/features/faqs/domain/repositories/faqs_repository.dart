import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/domain/entities/faq.dart';
import 'package:identidaddigital/core/error/failures.dart';

abstract class FaqsRepository {
  Future<Either<Failure, List<Faq>>> requestFaqs();
  Future<Either<Failure, List<Faq>>> requestExternalFaqs();
}
