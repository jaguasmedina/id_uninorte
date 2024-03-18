import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/features/auth/domain/repositories/login_repository.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';

@injectable
class ChangeExternalPasswordBloc extends BaseBloc {
  final LoginRepository _loginRepository;
  final AuthCredentials _credentials = AuthCredentials();

  ChangeExternalPasswordBloc(this._loginRepository);

  Future<Either<Failure, Unit>> changePasswordForExternalUser() async {
    return _loginRepository.changePasswordForExternalUser(_credentials);
  }

  void changeUsername(String value) {
    _credentials.username = value;
  }

  void changePassword(String value) {
    _credentials.password = value;
  }
}
