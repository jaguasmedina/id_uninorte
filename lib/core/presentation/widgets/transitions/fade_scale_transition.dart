import 'package:flutter/material.dart';

class FadeScaleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const FadeScaleTransition({
    Key key,
    @required this.animation,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ));
    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child,
      ),
    );
  }
}
