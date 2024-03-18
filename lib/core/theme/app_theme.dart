import 'package:flutter/material.dart';
import 'package:identidaddigital/core/presentation/widgets/route_builders/awesome_page_transition_builder.dart';
import 'package:identidaddigital/core/theme/app_theme_data.dart';
import 'package:identidaddigital/core/utils/colors.dart';
import 'package:identidaddigital/core/utils/fonts.dart';

export 'package:identidaddigital/core/theme/app_theme_data.dart';

class AppTheme extends InheritedWidget {
  @override
  final Widget child;
  final AppThemeData data;

  const AppTheme({
    Key key,
    @required this.child,
    @required this.data,
  }) : super(key: key, child: child);

  static AppThemeData of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(inherited?.data != null);
    return inherited.data;
  }

  /// App's light theme.
  ///
  /// Used as [MaterialApp.theme] property.
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primarySwatch: ColorSwatchs.primarySwatch,
    accentColor: AppColors.institutionalColor,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    fontFamily: Fonts.primaryFont,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.accentColor,
      selectionHandleColor: AppColors.institutionalColor,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: AwesomePageTransitionBuilder(),
      TargetPlatform.iOS: AwesomePageTransitionBuilder(),
    }),
  );

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return oldWidget.child != child;
  }
}
