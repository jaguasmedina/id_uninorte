import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class IconLabelInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String label;
  final VoidCallback onTap;
  final EdgeInsetsGeometry iconPadding;

  const IconLabelInfo({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.label,
    this.onTap,
    this.iconPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoFeedbackButton(
      onTap: onTap,
      child: Column(
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
          SizedBox(
            height: 31.0,
            child: Text(
              label,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
