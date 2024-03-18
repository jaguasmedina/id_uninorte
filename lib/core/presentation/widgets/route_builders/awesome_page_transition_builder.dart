import 'package:flutter/material.dart';

class AwesomePageTransitionBuilder extends PageTransitionsBuilder {
  /// Construct a [AwesomePageTransitionBuilder].
  const AwesomePageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _AwesomePageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}

class _AwesomePageTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  const _AwesomePageTransition({
    Key key,
    this.animation,
    this.secondaryAnimation,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> primaryTranslationAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(animation);

    final Animation<double> secondaryScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(secondaryAnimation);

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return SlideTransition(
          position: primaryTranslationAnimation,
          child: child,
        );
      },
      child: AnimatedBuilder(
        animation: secondaryAnimation,
        builder: (BuildContext context, Widget child) {
          return ScaleTransition(
            scale: secondaryScaleAnimation,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
