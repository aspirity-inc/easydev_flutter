import 'dart:math';

import 'package:flutter/widgets.dart';

/// Paints circle with rounded edges with width equals to [lineWidth]
/// and [SweepGradient] determined by [color], [surfaceColor] and [stops].
class CircularLoadingIndicatorPainter extends CustomPainter {
  final Color color;
  final Color surfaceColor;
  final List<double> stops;
  final double lineWidth;

  CircularLoadingIndicatorPainter({
    required this.color,
    required this.surfaceColor,
    required this.stops,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final xCenter = size.width * 0.5;
    final yCenter = size.height * 0.5;
    final center = Offset(xCenter, yCenter);

    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..shader = SweepGradient(
        colors: [
          color,
          surfaceColor,
        ],
        stops: stops,
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: 0,
        ),
      );

    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: size.width - lineWidth,
        height: size.height - lineWidth,
      ),
      0.12 * pi,
      1.76 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularLoadingIndicatorPainter oldDelegate) {
    return color != oldDelegate.color ||
        stops != oldDelegate.stops ||
        lineWidth != oldDelegate.lineWidth;
  }
}
