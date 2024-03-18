import 'package:flutter/services.dart';

/// A [TextInputFormatter] that prevents the insertion of white spaces.
class WhiteSpaceTextInputFormatter extends FilteringTextInputFormatter {
  /// Creates a formatter that prevents the insertion of white spaces.
  WhiteSpaceTextInputFormatter() : super(' ', allow: false);
}
