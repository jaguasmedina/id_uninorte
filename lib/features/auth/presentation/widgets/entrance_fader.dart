import 'package:flutter/material.dart';

class EntranceFader extends StatefulWidget {
  /// Child to be animated on entrance.
  final Widget child;

  /// Delay after which the animation will start.
  final Duration delay;

  /// Duration of entrance animation.
  final Duration duration;

  /// Starting point from which the widget will fade to its default position.
  final Offset offset;

  const EntranceFader({
    Key key,
    @required this.child,
    this.delay = const Duration(),
    this.duration = const Duration(milliseconds: 400),
    this.offset = const Offset(0.0, 32.0),
  })  : assert(delay != null),
        assert(duration != null),
        assert(offset != null),
        super(key: key);

  @override
  EntranceFaderState createState() {
    return EntranceFaderState();
  }
}

class EntranceFaderState extends State<EntranceFader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _EntranceFaderBuilder(
      animation: _controller,
      offset: widget.offset,
      child: widget.child,
    );
  }
}

class _EntranceFaderBuilder extends StatelessWidget {
  final Listenable animation;
  final Widget child;
  final Offset offset;

  const _EntranceFaderBuilder({
    Key key,
    @required this.animation,
    @required this.child,
    this.offset = const Offset(0.0, 32.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dxAnimation = Tween<double>(
      begin: offset.dx,
      end: 0.0,
    ).animate(animation);

    final dyAnimation = Tween<double>(
      begin: offset.dy,
      end: 0.0,
    ).animate(animation);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform.translate(
            offset: Offset(dxAnimation.value, dyAnimation.value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
