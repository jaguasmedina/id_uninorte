import 'package:flutter/material.dart';

class ConstrainedDialog extends StatelessWidget {
  final Widget child;

  const ConstrainedDialog({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = Size.fromWidth(400.0);
    
    return ConstrainedBox(
      constraints: BoxConstraints.loose(size),
      child: child,
    );
  }
}
