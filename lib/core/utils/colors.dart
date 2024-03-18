import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFFE3E4E5);
  static const Color accentColor = Color(0xFFE60000);
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF000000);
  static const Color secondaryHeaderColor = Color(0xFFF5F5F5);

  /// Color institucional.
  static const Color institutionalColor = Color(0xFFD72B32);
  static const Color accentDarkColor = Color(0xFF99000F);
}

class ColorMaps {
  static const Map<int, Color> redMap = {
    50: Color(0xFFFBE9EA),
    100: Color(0xFFF7D4D6),
    200: Color(0xFFF3BFC1),
    300: Color(0xFFEFAAAD),
    400: Color(0xFFEB9498),
    500: Color(0xFFE77F84),
    600: Color(0xFFE36A6F),
    700: Color(0xFFDF555B),
    800: Color(0xFFDB3F46),
    900: Color(0xFFD72B32),
  };
}

class ColorSwatchs {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFFD72B32,
    ColorMaps.redMap,
  );
}

extension HexColor on Color {
  static Color parse(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color tryParse(String hexString) {
    try {
      return HexColor.parse(hexString);
    } catch (e) {
      return Colors.black;
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
