import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DayNightAnnotatedRegion extends StatelessWidget {
  final Brightness brightness;
  final Widget child;

  const DayNightAnnotatedRegion({
    Key key,
    @required this.child,
    this.brightness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Brightness brightness = this.brightness ??
        theme.appBarTheme.brightness ??
        theme.primaryColorBrightness;

    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: child,
    );
  }
}
