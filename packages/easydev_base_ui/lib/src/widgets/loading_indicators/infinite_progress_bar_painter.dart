import 'package:flutter/widgets.dart';

/// Paints indicator with part with [trackColor]
/// in the [position].
class InfiniteProgressBarPainter extends CustomPainter {
  final Color color;
  final Color trackColor;
  final double position;

  InfiniteProgressBarPainter(
    this.color,
    this.trackColor,
    this.position,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final trackPainter = Paint()
      ..color = trackColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    final linePainter = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    const start = Offset(0, 4);
    final end = Offset(size.width, 4);

    canvas.drawLine(
      start,
      end,
      trackPainter,
    );
    if (position <= 0.5 && position != 0) {
      canvas.drawLine(
        start,
        Offset(size.width * position, 4),
        linePainter,
      );
    }
    if (position > 0.5 && position < 1) {
      canvas.drawLine(
        Offset(size.width * (position - 0.5), 4),
        Offset(size.width * position, 4),
        linePainter,
      );
    }
    if (position >= 1 && position != 1.5) {
      canvas.drawLine(
        Offset(size.width - ((1.5 - position) * size.width), 4),
        end,
        linePainter,
      );
    }
  }

  @override
  bool shouldRepaint(InfiniteProgressBarPainter oldDelegate) {
    return color != oldDelegate.color ||
        trackColor != oldDelegate.trackColor ||
        position != oldDelegate.position;
  }
}
