import 'dart:ui';

import 'package:flutter/widgets.dart';

class DashPainter extends CustomPainter {
  final double strokeWidth;
  final List<double> dashPattern;
  final Color? color;
  final Radius radius;
  final StrokeCap strokeCap;
  final EdgeInsets padding;

  DashPainter({
    this.strokeWidth = 2,
    this.dashPattern = const <double>[5, 5],
    this.color,
    this.radius = const Radius.circular(8),
    this.strokeCap = StrokeCap.butt,
    this.padding = EdgeInsets.zero,
  }) {
    assert(dashPattern.isNotEmpty, 'Dash Pattern cannot be empty');
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Size paintSize;
    if (padding == EdgeInsets.zero) {
      paintSize = size;
    } else {
      canvas.translate(padding.left, padding.top);
      paintSize = Size(
        size.width - padding.horizontal,
        size.height - padding.vertical,
      );
    }

    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color ?? const Color(0xFF000000)
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    Path path = dashPath(
      _getRRectPath(paintSize, radius),
      dashArray: CircularIntervalList(dashPattern),
    );

    canvas.drawPath(path, paint);
  }

  Path _getRRectPath(Size size, Radius radius) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          radius,
        ),
      );
  }

  @override
  bool shouldRepaint(DashPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.padding != padding;
  }

  Path dashPath(
    Path source, {
    required CircularIntervalList<double> dashArray,
    double? dashOffset,
  }) {
    dashOffset = dashOffset ?? 0.0;

    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = dashOffset;
      bool draw = true;
      while (distance < metric.length) {
        final double len = dashArray.next;
        if (draw) {
          dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
        }
        distance += len;
        draw = !draw;
      }
    }

    return dest;
  }
}

class CircularIntervalList<T> {
  CircularIntervalList(this.values);

  final List<T> values;
  int index = 0;

  T get next {
    if (index >= values.length) {
      index = 0;
    }
    return values[index++];
  }
}
