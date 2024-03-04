import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/material.dart';

/// {@macro flutter.rendering.custom_paint}
/// Internal [CustomPainter] for painting tooltips in [EasyDevRangeSlider].
/// Paints only tooltip above handle that is currently dragged.
class RangeTooltipPainter extends CustomPainter {
  const RangeTooltipPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.sliderHandleRadius,
    required this.textPainterLeft,
    required this.textPainterRight,
    required this.tooltipColor,
    required this.showStartTooltip,
    required this.showEndTooltip,
  });

  final RangeValue value;
  final double min;
  final double max;
  final double sliderHandleRadius;
  final TextPainter textPainterLeft;
  final TextPainter textPainterRight;
  final Color tooltipColor;
  final bool showStartTooltip;
  final bool showEndTooltip;

  @override
  void paint(Canvas canvas, Size size) {
    final tooltipPainter = Paint()..color = tooltipColor;
    if (showStartTooltip) {
      _paintTooltip(canvas, size, tooltipPainter, textPainterLeft, value.start);
    } else if (showEndTooltip) {
      _paintTooltip(canvas, size, tooltipPainter, textPainterRight, value.end);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _paintTooltip(
    Canvas canvas,
    Size size,
    Paint tooltipPainter,
    TextPainter textPainter,
    double value,
  ) {
    var position =
        (value - min) * (size.width - 2 * sliderHandleRadius) / (max - min) + sliderHandleRadius;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(position, (size.height - 15) / 2),
          width: textPainter.width + 20,
          height: size.height - 15,
        ),
        const Radius.circular(4),
      ),
      tooltipPainter,
    );
    Path path = Path()
      ..moveTo(position, size.height - 9)
      ..lineTo(position + 6, size.height - 15)
      ..lineTo(position - 6, size.height - 15)
      ..lineTo(position, size.height - 9);
    canvas.drawPath(path, tooltipPainter);
    textPainter.paint(
      canvas,
      Offset(
        position - textPainter.width / 2,
        (size.height - textPainter.height) / 2 - 5,
      ),
    );
  }
}
