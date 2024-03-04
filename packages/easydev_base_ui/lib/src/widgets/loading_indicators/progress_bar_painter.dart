import 'dart:math';

import 'package:flutter/widgets.dart';

/// Paints line with rounded edges with a [percentage]
/// of the [progressColor] and the rest of the [color].
class ProgressBarPainter extends CustomPainter {
  final Color color;
  final Color progressColor;
  final double percentage;

  ProgressBarPainter(
    this.color,
    this.progressColor,
    this.percentage,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 1;

    final backgroundPaint = Paint()
      ..color = color
      ..strokeWidth = 1;

    _paintEmptyLine(canvas, size, backgroundPaint);
    _paintFillLine(canvas, size, progressPaint, percentage);
  }

  @override
  bool shouldRepaint(ProgressBarPainter oldDelegate) {
    return color != oldDelegate.color ||
        progressColor != oldDelegate.progressColor ||
        percentage != oldDelegate.percentage;
  }

  void _paintEmptyLine(Canvas canvas, Size size, Paint paint) {
    Path path = Path()
      ..moveTo(4, 0)
      ..lineTo(size.width - 8, 0)
      ..arcTo(
        Rect.fromLTRB(size.width - 8, 0, size.width, 8),
        3 * pi / 2,
        pi,
        false,
      )
      ..lineTo(8, 8)
      ..arcTo(
        const Rect.fromLTRB(0, 0, 8, 8),
        pi / 2,
        pi,
        false,
      );
    canvas
      ..drawPath(path, paint)
      ..clipPath(path);
  }

  void _paintFillLine(Canvas canvas, Size size, Paint paint, double percentage) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * percentage - 8, 0)
      ..arcTo(
        Rect.fromLTRB(
          size.width * percentage - 8,
          0,
          size.width * percentage,
          8,
        ),
        3 * pi / 2,
        pi,
        false,
      )
      ..lineTo(0, 8);
    canvas.drawPath(path, paint);
  }
}
