import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'package:identidaddigital/core/utils/my_icons.dart';

class HologramBoxV2 extends StatelessWidget {
  final List<double> _values = [0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder<AccelerometerEvent>(
      stream: accelerometerEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _values[0] = snapshot.data.x;
          _values[1] = snapshot.data.y;
        }
        return _HologramMask(
          key: const Key('holo-mask'),
          begin: FractionalOffset(-(_values[0] / 8), (_values[1] - 4) / 8),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: _HologramItem(
              width: size.width * 0.53,
            ),
          ),
        );
      },
    );
  }
}

class _HologramMask extends StatelessWidget {
  final Widget child;
  final FractionalOffset begin;
  static const List<Color> colors = [
    Color(0xFF80E8DD),
    Color(0xFF80E8DD),
    Color(0xFF7CC2F6),
    Color(0xFFAF81E4),
    Color(0xFFE784BA),
    Color(0xFFF9C1A0),
    Color(0xFFB7F6AF),
    Color(0xFFB7F6AF),
  ];

  const _HologramMask({
    Key key,
    @required this.child,
    @required this.begin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect rect) {
          return LinearGradient(
            colors: colors,
            begin: begin,
            end: const FractionalOffset(0.0, 1.0),
          ).createShader(rect);
        },
        child: child,
      ),
    );
  }
}

class _HologramItem extends StatelessWidget {
  final double width;

  const _HologramItem({
    Key key,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: const FittedBox(
        child: Icon(
          MyIcons.roble,
        ),
      ),
    );
  }
}
