import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/custom_network_image.dart';
import 'package:identidaddigital/core/presentation/widgets/day_night_annotated_region.dart';
import 'package:identidaddigital/core/presentation/widgets/labeled_view.dart';
import 'package:identidaddigital/core/presentation/providers/user_provider.dart';
import 'package:identidaddigital/core/presentation/widgets/user_circle_avatar.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Widget trailing;
  final VoidCallback onLeadingPressed;

  static const preferredHeight = 60.0;

  const UserAppBar({
    Key key,
    this.backgroundColor,
    this.trailing,
    @required this.onLeadingPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(preferredHeight);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[_buildAvatar(context)];
    if (trailing != null) {
      children.add(Flexible(child: trailing));
    }
    return DayNightAnnotatedRegion(
      brightness: Brightness.light,
      child: Material(
        color: backgroundColor,
        child: SafeArea(
          child: SizedBox(
            height: preferredHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final localizations = AppLocalizations.of(context);
    return user != null
        ? NoFeedbackButton(
            onTap: onLeadingPressed,
            child: LabeledView(
              label: localizations.translate('my_carnet'),
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(const Size(40.0, 40.0)),
                child: UserCircleAvatar(
                  child: CustomNetworkImage(
                    fit: BoxFit.cover,
                    data: user.picture,
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}

class NoFeedbackButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const NoFeedbackButton({
    Key key,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
