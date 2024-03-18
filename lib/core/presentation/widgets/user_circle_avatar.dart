import 'package:flutter/material.dart';

class UserCircleAvatar extends StatelessWidget {
  final Widget child;

  /// Construct a circle clipped widget. The size is given by its parent.
  const UserCircleAvatar({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.0, 2.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: ClipOval(
          child: child,
        ),
      ),
    );
  }
}
