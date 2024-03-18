import 'package:flutter/material.dart';

class SizeRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  SizeRoute(this.child)
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
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
        );
}
