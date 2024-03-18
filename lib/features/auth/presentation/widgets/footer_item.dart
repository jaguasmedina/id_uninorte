import 'package:flutter/material.dart';

class FooterItem extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const FooterItem({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
