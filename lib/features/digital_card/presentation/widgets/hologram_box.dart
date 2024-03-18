import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'package:identidaddigital/core/utils/my_icons.dart';

class HologramBox extends StatelessWidget {
  final List<double> _values = [0.0, 0.0];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final itemWidth = constraints.maxWidth / 3;
        final columns = constraints.maxWidth / itemWidth;
        final rows = (constraints.maxHeight - 30.0) / itemWidth;
        // final totalOfItems = columns.floor() * rows.floor();
        final children = <Widget>[];
        for (int i = 1; i <= rows; i++) {
          final rowChildren = <Widget>[];
          for (int j = 1; j <= columns; j++) {
            rowChildren.add(_HologramItem(
              key: ValueKey('$i$j'),
              width: itemWidth,
            ));
          }
          if (i.isOdd) {
            children.add(Transform.translate(
              offset: const Offset(10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: rowChildren,
              ),
            ));
          } else {
            children.add(Transform.translate(
              offset: const Offset(-10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: rowChildren,
              ),
            ));
          }
        }
        return StreamBuilder(
          stream: accelerometerEvents,
          builder: (BuildContext context,
              AsyncSnapshot<AccelerometerEvent> snapshot) {
            if (snapshot.hasData) {
              _values[0] = snapshot.data.x;
              _values[1] = snapshot.data.y;
            }
            return _HologramMask(
              key: const Key('holo-mask'),
              begin: FractionalOffset(-(_values[0] / 8), (_values[1] - 4) / 8),
              child: Column(
                key: const Key('holo-wrap'),
                children: children,
              ),
            );
          },
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
      opacity: 0.2,
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
    return Container(
      margin: EdgeInsets.all(width / 4),
      width: width / 2,
      height: width / 2,
      child: const Icon(MyIcons.tree, size: 50,),
    );
  }
}
