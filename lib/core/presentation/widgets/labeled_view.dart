import 'package:flutter/material.dart';

enum LabelPosition { left, right }

class LabeledView extends StatelessWidget {
  final Widget child;
  final String label;
  final LabelPosition position;

  const LabeledView({
    Key key,
    @required this.child,
    @required this.label,
    this.position = LabelPosition.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (position == LabelPosition.right) {
      children.add(child);
      children.add(Flexible(child: LabelText(label)));
    } else {
      children.add(Flexible(child: LabelText(label)));
      children.add(child);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String text;
  const LabelText(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
