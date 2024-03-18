part of core.data.analytics;

@immutable
abstract class AppEvent {
  const AppEvent(this.name);

  final String name;

  Map<String, String> buildParameters() => const {};

  @override
  String toString() => '$runtimeType(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppEvent &&
        other.runtimeType == runtimeType &&
        other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class LoginAttempt extends AppEvent {
  const LoginAttempt(
    this.email,
  ) : super('login_attempt');

  final String email;

  @override
  Map<String, String> buildParameters() => <String, String>{'email': email};
}
