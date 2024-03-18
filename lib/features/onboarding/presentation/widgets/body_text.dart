import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const BodyText(
    this.text, {
    Key key,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class BodyRichText extends StatelessWidget {
  final List<TextSpan> children;
  final TextAlign textAlign;

  const BodyRichText({
    Key key,
    @required this.children,
    this.textAlign = TextAlign.center,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: children,
      ),
      style: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.normal,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

class BoldTextSpan extends TextSpan {
  const BoldTextSpan({
    String text,
  }) : super(
          text: text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        );
}
