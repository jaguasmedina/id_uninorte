import 'package:injectable/injectable.dart';
import 'package:identidaddigital/core/domain/repositories/destination_repository.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';

@injectable
class OnboardingBloc extends BaseBloc {
  final DestinationRepository _destinationRepository;

  OnboardingBloc(this._destinationRepository);

  String requestDestination() {
    return _destinationRepository.requestOnboardingDestination();
  }

  void saveOnboardingDidShow() {
    _destinationRepository.saveOnboardingDidShow();
  }
}
