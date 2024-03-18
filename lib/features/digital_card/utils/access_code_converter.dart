import 'dart:convert';

class AccessCodeConverter {
  static const separator = './';

  /// Encode de given [List] to a base64 [String] by joining each
  /// element with a [separator] character.
  static String encode(List<String> params) {
    final data = params.join(separator);
    final bytes = utf8.encode(data);
    final base64str = base64.encode(bytes);
    return base64str;
  }
}
