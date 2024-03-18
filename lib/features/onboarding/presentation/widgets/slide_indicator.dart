import 'package:flutter/material.dart';

class SlideIndicator extends StatelessWidget {
  final int length;
  final double currentSlide;

  const SlideIndicator({
    Key key,
    @required this.currentSlide,
    @required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50.0,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (int i) {
          final isCurrentSlide = currentSlide.round() == i;
          final size = isCurrentSlide ? 14.0 : 14.0;
          final color = isCurrentSlide ? theme.accentColor : Colors.white;
          final borderColor = isCurrentSlide ? theme.accentColor : Colors.black;
          return AnimatedContainer(
            width: size,
            height: size,
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor),
            ),
          );
        }),
      ),
    );
  }
}
