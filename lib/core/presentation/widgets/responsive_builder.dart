import 'package:flutter/material.dart';
import 'package:identidaddigital/core/enums/screen_type.dart';
import 'package:identidaddigital/core/extensions/size_extension.dart';

export 'package:identidaddigital/core/enums/screen_type.dart';

typedef ResponsiveWidgetBuilder = Widget Function(BuildContext, ScreenType);

class ResponsiveBuilder extends StatelessWidget {
  final ResponsiveWidgetBuilder builder;

  const ResponsiveBuilder({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    ScreenType screenType = ScreenType.mobile;
    if (media.size.isTablet) {
      screenType = ScreenType.tablet;
    }
    return builder(context, screenType);
  }
}
