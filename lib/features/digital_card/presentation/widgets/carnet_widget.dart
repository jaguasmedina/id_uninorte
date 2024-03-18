import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:identidaddigital/features/digital_card/presentation/widgets/widgets.dart';

class CarnetWidget extends StatefulWidget {
  final Widget front;
  final Widget back;
  final ValueChanged<bool> onFlipped;
  final VoidCallback onTap;

  const CarnetWidget({
    Key key,
    @required this.front,
    @required this.back,
    this.onFlipped,
    this.onTap,
  }) : super(key: key);

  @override
  CarnetWidgetState createState() => CarnetWidgetState();
}

class CarnetWidgetState extends State<CarnetWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Runs a flip animation forward or backward.
  void flip() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
      widget.onFlipped(true);
    } else if (_animationController.isDismissed) {
      _animationController.forward();
      widget.onFlipped(false);
    }
  }

  /// Tries to flip this widget backwards.
  Future<bool> maybeFlip() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
      widget.onFlipped(true);
      return true;
    } else {
      return false;
    }
  }

  bool _isAnimating() {
    return _animationController.isAnimating || _animationController.isDismissed;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(math.pi * _animation.value);

          return Transform(
            transform: transform,
            alignment: FractionalOffset.center,
            child: AnimationNotifier(
              isAnimating: _isAnimating(),
              child: _buildCarnetSide(_animation.value),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarnetSide(double value) {
    final isBack = value >= 0.5;
    final child = isBack ? widget.back : widget.front;
    // final topLayer = isBack ? Container() : Container(); // HologramBox();
    return CarnetContainer(
      // topLayer: topLayer,
      child: child,
    );
  }
}
