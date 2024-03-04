import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// {@macro flutter.rendering.custom_paint}
/// Internal [CustomPainter] for painting tooltips in [EasyDevSlider].
class TooltipPainter extends CustomPainter {
  const TooltipPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.sliderHandleRadius,
    required this.textPainter,
    required this.tooltipColor,
  });

  final double value;
  final double min;
  final double max;
  final double sliderHandleRadius;
  final TextPainter textPainter;
  final Color tooltipColor;

  @override
  void paint(Canvas canvas, Size size) {
    final tooltipPainter = Paint()..color = tooltipColor;

    _paintTooltip(canvas, size, tooltipPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _paintTooltip(Canvas canvas, Size size, Paint tooltipPainter) {
    var position =
        (value - min) * (size.width - 2 * sliderHandleRadius) / (max - min) + sliderHandleRadius;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(position, size.height / 2),
          width: textPainter.width + 20,
          height: size.height - 15,
        ),
        const Radius.circular(4),
      ),
      tooltipPainter,
    );
    Path path = Path()
      ..moveTo(position - 6, size.height - 9)
      ..lineTo(position + 6, size.height - 9)
      ..lineTo(position, size.height)
      ..lineTo(position - 6, size.height - 9);
    canvas.drawPath(path, tooltipPainter);
    textPainter.paint(
      canvas,
      Offset(
        position - textPainter.width / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }
}
