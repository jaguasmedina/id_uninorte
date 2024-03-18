import 'package:flutter/material.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SimpleAppBar({
    Key key,
    @required this.icon,
    @required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: SizedBox(
          height: 60.0,
          child: NoFeedbackButton(
            onTap: onTap,
            child: LabeledView(
              label: title,
              child: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}
