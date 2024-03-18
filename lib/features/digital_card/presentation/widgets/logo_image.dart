import 'package:flutter/material.dart';
import 'package:identidaddigital/core/presentation/widgets/responsive_builder.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;

class LogoImage extends StatelessWidget {
  const LogoImage();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, ScreenType screenType) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: FractionallySizedBox(
            widthFactor: screenType.isMobile ? 0.46 : 0.4,
            child: const Image(
              image: AssetImage(utils.Assets.logoLarge),
            ),
          ),
        );
      },
    );
  }
}
