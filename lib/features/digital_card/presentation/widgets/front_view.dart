import 'package:flutter/material.dart';

import 'package:identidaddigital/core/domain/entities/user_profile.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;
import 'package:identidaddigital/features/digital_card/presentation/widgets/diagonal_painter.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/hologram_box_v2.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/logo_image.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/profile_selector.dart';

class FrontView extends StatelessWidget {
  final String photo;
  final String name;
  final String id;
  final PageController profileController;
  final List<UserProfile> profiles;
  final Color profileColor;
  final bool showRolControllers;
  final Stream<String> clockStream;
  final VoidCallback onNextProfile;
  final VoidCallback onPrevProfile;
  final ValueChanged<int> onProfileChanged;

  const FrontView({
    Key key,
    @required this.clockStream,
    @required this.photo,
    @required this.name,
    @required this.id,
    @required this.profileController,
    @required this.profiles,
    @required this.profileColor,
    this.onNextProfile,
    this.onPrevProfile,
    this.onProfileChanged,
    this.showRolControllers = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayNightAnnotatedRegion(
      brightness: Brightness.dark,
      child: CustomPaint(
        painter: DiagonalPainter(
          color: AppTheme.of(context).secondaryColor,
          offset: MediaQuery.of(context).viewPadding.top,
        ),
        child: SafeArea(
          child: ResponsiveBuilder(
            builder: (BuildContext context, ScreenType screenType) {
              return Stack(
                children: <Widget>[
                  _buildHologram(context),
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 16.0),
                      _buildTimeText(context),
                      _buildUserImage(context, screenType),
                      _buildUserName(context, screenType),
                      _buildUserID(screenType),
                      const SizedBox(height: 16.0),
                      _buildUserProfile(context),
                      _buildLogo(),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTimeText(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: StreamBuilder<String>(
        stream: clockStream,
        initialData: utils.DateFormatter.formatNow(),
        builder: (context, snapshot) {
          return Text(
            snapshot.data,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return const LogoImage();
  }

  Widget _buildUserImage(BuildContext context, ScreenType screenType) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width * (screenType.isMobile ? 0.5 : 0.4);
    final boxSize = Size(maxWidth, maxWidth);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(boxSize),
            child: UserCircleAvatar(
              child: CustomNetworkImage(
                data: photo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserName(BuildContext context, ScreenType screenType) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Text(
          name.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenType.isMobile ? 23.0 : 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUserID(ScreenType screenType) {
    return FittedBox(
      child: Text(
        'CIU $id',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenType.isMobile ? 23.0 : 32.0,
          fontWeight: FontWeight.w100,
          fontFamily: utils.Fonts.secondaryFont,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return ProfileSelector(
      controller: profileController,
      color: profileColor,
      profiles: profiles,
      onPrevPressed: onPrevProfile,
      onNextPressed: onNextProfile,
      onProfileChanged: onProfileChanged,
      showActions: showRolControllers,
    );
  }

  Widget _buildHologram(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: HologramBoxV2(),
    );
  }
}
