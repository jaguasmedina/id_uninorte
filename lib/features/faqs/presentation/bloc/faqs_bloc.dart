import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/domain/entities/faq.dart';
import 'package:identidaddigital/core/enums/page_state.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/features/faqs/domain/repositories/faqs_repository.dart';
import 'package:identidaddigital/core/presentation/bloc/base_bloc.dart';

@injectable
class FaqsBloc extends BaseBloc {
  final FaqsRepository _repository;
  Failure _failure;
  List<Faq> _faqs = [];

  FaqsBloc(this._repository);

  @override
  PageState get initialState => PageState.busy;

  Failure get failure => _failure;
  List<Faq> get faqs => _faqs;

  Future<Either<Failure, List<Faq>>> requestFaqs() async {
    setState(PageState.busy);
    _failure = null;
    final result = await _repository.requestFaqs();
    result.fold(
      (failure) {
        _failure = failure;
        setState(PageState.error);
      },
      (faqs) {
        _faqs = faqs;
        setState(PageState.completed);
      },
    );
    return result;
  }

  Future<Either<Failure, List<Faq>>> requestExternalFaqs() async {
    setState(PageState.busy);
    _failure = null;
    final result = await _repository.requestExternalFaqs();
    result.fold(
      (failure) {
        _failure = failure;
        setState(PageState.error);
      },
      (faqs) {
        _faqs = faqs;
        setState(PageState.completed);
      },
    );
    return result;
  }
}
