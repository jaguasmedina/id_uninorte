import 'package:meta/meta.dart';
import 'package:identidaddigital/core/domain/entities/entities.dart';

class AuthCredentialsModel extends AuthCredentials {
  AuthCredentialsModel({
    @required String username,
    @required String password,
  }) : super(
          username: username,
          password: password,
        );

  factory AuthCredentialsModel.fromEntity(AuthCredentials entity) {
    return AuthCredentialsModel(
      username: entity.username,
      password: entity.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': username,
      'password': password,
    };
  }
}
