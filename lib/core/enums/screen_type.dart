enum ScreenType {
  mobile,
  tablet,
}

extension ScreenTypeExtension on ScreenType {
  /// Whether this represents a mobile screen.
  bool get isMobile => this == ScreenType.mobile;

  /// Whether this represents a tablet screen.
  bool get isTablet => this == ScreenType.tablet;
}
