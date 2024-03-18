import 'package:intl/intl.dart';

class DateFormatter {
  /// Returns a [String] representing [dateTime] formatted
  /// by the given [format].
  ///
  /// If an exception is thrown, returns [fallback].
  static String formatDate(
    DateTime dateTime, [
    String format = 'EEEE dd MMM yyyy',
    String fallback = '',
  ]) {
    try {
      final dateFormat = DateFormat(format);
      final string = dateFormat.format(dateTime);
      return string;
    } catch (e) {
      return fallback;
    }
  }

  static String formatNow() {
    return formatDate(
      DateTime.now(),
      'EEEE, MMM dd. yyyy\n hh:mm:ss a',
    );
  }
}
