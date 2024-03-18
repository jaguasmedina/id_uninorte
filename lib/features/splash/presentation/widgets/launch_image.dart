import 'package:flutter/material.dart';
import 'package:identidaddigital/core/utils/utils.dart';

class LaunchImage extends StatelessWidget {
  const LaunchImage();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'launch-image',
      child: SizedBox(
        width: 136.0,
        height: 136.0,
        child: Image.asset(Assets.launchLogo),
      ),
    );
  }
}
