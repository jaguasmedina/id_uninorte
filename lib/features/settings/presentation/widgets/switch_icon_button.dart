import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool enabled;
  final EdgeInsetsGeometry iconPadding;
  final ValueChanged<bool> onChanged;

  const SwitchIconButton({
    Key key,
    @required this.icon,
    @required this.title,
    this.enabled = true,
    this.iconPadding = EdgeInsets.zero,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: iconPadding,
            child: FittedBox(
              child: Icon(icon),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12.0),
        CupertinoSwitch(
          value: enabled,
          activeColor: Theme.of(context).accentColor,
          onChanged: onChanged,
        )
      ],
    );
  }
}
