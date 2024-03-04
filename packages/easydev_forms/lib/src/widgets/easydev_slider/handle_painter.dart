import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// {@macro flutter.rendering.custom_paint}
/// Internal [CustomPainter] for painting [EasyDevSlider] handle.
class HandlePainter extends CustomPainter {
  const HandlePainter({
    required this.value,
    required this.min,
    required this.max,
    required this.sliderHandleRadius,
    required this.sliderHandleWidth,
    required this.handleColor,
    required this.selectedTrackColor,
    this.divisions,
  });

  final double value;
  final double min;
  final double max;
  final double sliderHandleRadius;
  final double sliderHandleWidth;
  final Color handleColor;
  final Color selectedTrackColor;
  final int? divisions;

  @override
  void paint(Canvas canvas, Size size) {
    final handlePainter = Paint()..color = handleColor;

    final handleBorderPainter = Paint()..color = selectedTrackColor;

    var handleCenterPosition =
        ((value - min) * (size.width - sliderHandleRadius * 2) / (max - min)) + sliderHandleRadius;

    if (divisions != null) {
      var divisionCoordinates = <double>[sliderHandleRadius];
      final step = (size.width - sliderHandleRadius * 2) / divisions!;
      var currentX = step;
      for (int i = 1; i < divisions!; i++) {
        divisionCoordinates.add(currentX + sliderHandleRadius);
        currentX += step;
      }
      divisionCoordinates.add(size.width - sliderHandleRadius);

      handleCenterPosition = divisionCoordinates.reduce(
        (a, b) => (a - handleCenterPosition).abs() <= (b - handleCenterPosition).abs() ? a : b,
      );
    }
    _printHandleBorder(canvas, size, handleBorderPainter, handleCenterPosition);
    _paintHandle(canvas, size, handlePainter, handleCenterPosition);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _paintHandle(Canvas canvas, Size size, Paint paint, double centerCoordinate) {
    canvas.drawCircle(
      Offset(centerCoordinate, size.height / 2),
      sliderHandleRadius - sliderHandleWidth,
      paint,
    );
  }

  void _printHandleBorder(Canvas canvas, Size size, Paint paint, double centerCoordinate) {
    canvas.drawCircle(
      Offset(centerCoordinate, size.height / 2),
      sliderHandleRadius,
      paint,
    );
  }
}
