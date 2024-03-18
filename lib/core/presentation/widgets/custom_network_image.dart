import 'dart:convert';

import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  /// Data to display.
  final String data;

  /// Widget displayed while the [data] is loading.
  final Widget placeholder;

  final BoxFit fit;

  static const fadeDuration = Duration(milliseconds: 300);

  const CustomNetworkImage({
    Key key,
    @required this.data,
    this.fit = BoxFit.contain,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: fit,
      gaplessPlayback: true,
      image: MemoryImage(
        base64Decode(data),
      ),
    );
  }

  Widget defaultPlaceholder() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }
}
