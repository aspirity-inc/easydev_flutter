import 'dart:math';

import 'package:flutter/widgets.dart';

/// Paints circular loading indicator
/// divided on descrete lines with [color].
class SpinningLoadingIndicatorPainter extends CustomPainter {
  final Color color;

  SpinningLoadingIndicatorPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeLength = size.width * 0.25;
    final padding = size.width * 0.05;
    const strokeWidth = 2.0;

    final xCenter = size.width * 0.5;
    final yCenter = size.height * 0.5;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    final innerRadius = (size.width - (padding * 2) - (strokeLength * 2)) * 0.5;
    final outerRadius = (size.width - (padding * 2)) * 0.5;

    for (int i = 0; i < 12; i++) {
      canvas.drawLine(
        _getPoint(innerRadius, xCenter, yCenter, i * 30),
        _getPoint(outerRadius, xCenter, yCenter, i * 30),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SpinningLoadingIndicatorPainter oldDelegate) {
    return color != oldDelegate.color;
  }

  Offset _getPoint(double radius, double xCenter, double yCenter, double angle) {
    final xPoint = xCenter + radius * cos(angle * pi / 180);
    final yPoint = yCenter + radius * sin(angle * pi / 180);

    return Offset(xPoint, yPoint);
  }
}
