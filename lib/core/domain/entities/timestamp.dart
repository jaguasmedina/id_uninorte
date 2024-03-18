import 'package:equatable/equatable.dart';

class Timestamp extends Equatable {
  static const _factor = 1000;
  static const _maxDaysToExpire = 5;

  /// Time in seconds.
  final int seconds;

  /// Creates a [Timestamp] instance with the given seconds.
  const Timestamp(this.seconds);

  /// Creates a [Timestamp] instance with current [secondsSinceEpoch].
  factory Timestamp.now() {
    return Timestamp(secondsSinceEpoch);
  }

  /// The number of seconds since the *Unix epoch* 1970-01-01T00:00:00Z (UTC).
  static int get secondsSinceEpoch {
    final milliseconds = DateTime.now().millisecondsSinceEpoch;
    final seconds = milliseconds / _factor;
    return seconds.toInt();
  }

  /// Whether this timestamp has expired.
  bool get isExpired {
    final diffInSeconds = secondsSinceEpoch - seconds;
    final diffInDays = diffInSeconds / 86400;
    return diffInDays > _maxDaysToExpire;
  }

  @override
  List<Object> get props => [seconds];

  @override
  String toString() {
    return seconds.toString();
  }
}
