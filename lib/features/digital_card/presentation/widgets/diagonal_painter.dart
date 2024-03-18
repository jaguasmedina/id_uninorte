import 'package:flutter/material.dart';

class DiagonalPainter extends CustomPainter {
  final Color color;
  final double offset;

  DiagonalPainter({
    @required this.color,
    this.offset = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint();

    paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    if (offset > 0) {
      path.lineTo(0.0, offset);
    }

    path.lineTo(size.width, size.height * 0.72);
    path.lineTo(size.width, 0.0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DiagonalPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.offset != offset;
  }
}
