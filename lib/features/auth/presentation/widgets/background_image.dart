import 'package:flutter/material.dart';

import 'package:identidaddigital/core/utils/utils.dart' as utils;

class BackgroundImage extends StatelessWidget {
  const BackgroundImage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: const Opacity(
        opacity: 0.1,
        child: Image(
          fit: BoxFit.cover,
          color: Color(0xFFE3E4E5),
          colorBlendMode: BlendMode.color,
          image: AssetImage(utils.Assets.background),
        ),
      ),
    );
  }
}
