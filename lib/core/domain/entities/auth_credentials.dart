import 'package:identidaddigital/core/utils/validators.dart';

class AuthCredentials {
  String username;
  String password;

  AuthCredentials({
    this.username,
    this.password,
  });

  bool get hasValidEmailAsUsername {
    return PatternValidators.isValidEmail(username);
  }

  AuthCredentials copyWith({
    String username,
    String password,
  }) {
    return AuthCredentials(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  /// Returns [AuthCredentials] with the given [value] joined
  /// to the previous [username].
  AuthCredentials concatToUsername(String value) {
    return AuthCredentials(
      username: username + value,
      password: password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthCredentials &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
