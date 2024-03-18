import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: const BorderSide(width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: child,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SecondaryButton({
    Key key,
    @required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
