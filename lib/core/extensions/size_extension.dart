import 'dart:ui';

extension SizeExtension on Size {
  /// Whether this represents a Tablet [Size].
  bool get isTablet {
    final deviceWidth = shortestSide;
    return deviceWidth >= 600.0;
  }

  /// Whether this represents a Mobile [Size].
  bool get isMobile {
    final deviceWidth = shortestSide;
    return deviceWidth < 600.0;
  }
}
