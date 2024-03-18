import 'dart:ui';

class SupportedLocales {
  static const _langCodes = ['es'];

  /// All supported language codes.
  static List<String> get langCodes => _langCodes;

  static List<Locale> get locales {
    return _langCodes.map<Locale>((value) {
      return Locale(value);
    }).toList();
  }
}
