import 'package:flutter/material.dart';

class AnimationNotifier extends InheritedWidget {
  @override
  final Widget child;
  final bool isAnimating;

  const AnimationNotifier({
    Key key,
    this.child,
    this.isAnimating = false,
  }) : super(key: key, child: child);

  static AnimationNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimationNotifier>();
  }

  @override
  bool updateShouldNotify(AnimationNotifier oldWidget) {
    return oldWidget.child != child || oldWidget.isAnimating != isAnimating;
  }
}
