import 'package:flutter/material.dart';
import 'package:identidaddigital/core/domain/entities/user_profile.dart';
import 'package:identidaddigital/core/presentation/widgets/responsive_builder.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;

class ProfileSelector extends StatelessWidget {
  final PageController controller;
  final Color color;
  final List<UserProfile> profiles;
  final bool showActions;
  final ValueChanged<int> onProfileChanged;
  final VoidCallback onNextPressed;
  final VoidCallback onPrevPressed;

  const ProfileSelector({
    Key key,
    @required this.controller,
    @required this.color,
    @required this.profiles,
    @required this.onNextPressed,
    @required this.onPrevPressed,
    this.onProfileChanged,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, ScreenType screenType) {
        final isMobile = screenType.isMobile;
        final iconSize = isMobile ? 40.0 : 50.0;
        final theme = Theme.of(context);
        final iconTheme = IconThemeData(
          color: Colors.white,
          size: iconSize,
        );
        return AnimatedContainer(
          height: isMobile ? 60.0 : 80.0,
          color: color,
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Theme(
            data: theme.copyWith(iconTheme: iconTheme),
            child: Row(
              children: <Widget>[
                if (showActions)
                  _IconButton(
                    onTap: onPrevPressed,
                    icon: Icons.chevron_left,
                  ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    onPageChanged: onProfileChanged,
                    children: profiles
                        .map((e) => FittedBox(
                              child: Text(
                                e.title.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: utils.Fonts.secondaryFont,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                if (showActions)
                  _IconButton(
                    onTap: onNextPressed,
                    icon: Icons.chevron_right,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({
    Key key,
    @required this.icon,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: double.infinity,
        child: Icon(icon),
      ),
    );
  }
}
