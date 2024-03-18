import 'package:flutter/material.dart';
import 'package:identidaddigital/core/presentation/widgets/responsive_builder.dart';

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, ScreenType screenType) {
        final isMobile = screenType.isMobile;
        final padding = isMobile ? 8.0 : 16.0;
        return Padding(
          padding: EdgeInsets.all(padding),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
    );
  }
}
