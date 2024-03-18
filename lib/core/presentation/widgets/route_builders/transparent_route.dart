import 'package:flutter/material.dart';

class TransparentRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  TransparentRoute({this.child})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return child;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

  @override
  bool get opaque => false;
}
