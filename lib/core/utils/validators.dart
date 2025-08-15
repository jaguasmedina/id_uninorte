/// Regex pattern validators.
class PatternValidators {
  /// Checks if the given [value] contains at least one number.
  static bool containsAtLeastOneNumber(String value) {
    const String pattern = '(?=.*?[0-9])';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /// Checks if the given [value] contains only numbers.
  static bool containsOnlyNumbers(String value) {
    const String pattern = r'^[0-9]*$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /// Checks if the given [value] represents a valid email address.
  static bool isValidEmail(String value) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /// Checks if the given [value] contains at least one letter.
  static bool hasLetter(String value) {
    const String pattern = '^(?=.*?[a-zA-Z])';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /// Checks if the given [value] contains at least one upper case letter.
  static bool hasUpperCase(String value) {
    const String pattern = '^(?=.*?[A-Z])';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /// Checks if the given [value] contains at least one lower case letter.
  static bool hasLowerCase(String value) {
    const String pattern = '(?=.*?[a-z])';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  /// Checks if the given [value] contains at least one special character.
  static bool hasSpecialCharacter(String value) {
    const String pattern = r'(?=.*?[#?!@$%^&*-])';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool isValidPassword(String value) {
    const String pattern =
        r'(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9._-]{8,18})$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool hasValidLength(String value) {
    const int minLength = 8;
    const int maxLength = 18;
    return value.length >= minLength && value.length <= maxLength;
  }
}

/// Class with functions to use as [Form.validator] property.
class FormValidators {
  static String? validateEmptyUsername(String value) {
    if (value.isEmpty) {
      return 'empty_username';
    } else {
      return null;
    }
  }

  static String? validateEmptyPassword(String value) {
    if (value.isEmpty) {
      return 'empty_password';
    } else {
      return null;
    }
  }

  static String? validatePasswordPattern(String value) {
    final isValid = PatternValidators.containsAtLeastOneNumber(value) &&
        PatternValidators.hasLetter(value) &&
        PatternValidators.isValidPassword(value);
    if (isValid) {
      return null;
    } else {
      return 'invalid_password';
    }
  }
}
