import 'package:easydev_forms/src/widgets/easydev_range_slider/easydev_range_slider.dart';
import 'package:easydev_forms/src/widgets/easydev_range_slider/range_value.dart';
import 'package:flutter/widgets.dart';

/// {@macro flutter.rendering.custom_paint}
/// Internal [CustomPainter] for painting [EasyDevRangeSlider] handles.
class RangeHandlePainter extends CustomPainter {
  const RangeHandlePainter({
    required this.value,
    required this.min,
    required this.max,
    required this.sliderHandleRadius,
    required this.sliderHandleWidth,
    required this.handleColor,
    required this.selectedTrackColor,
    required this.leftIsAbove,
    required this.minimalHandleDrawingRange,
    this.divisions,
  });

  final RangeValue value;
  final double min;
  final double max;
  final double sliderHandleRadius;
  final double sliderHandleWidth;
  final Color handleColor;
  final Color selectedTrackColor;
  final bool leftIsAbove;
  final double minimalHandleDrawingRange;
  final int? divisions;

  @override
  void paint(Canvas canvas, Size size) {
    final handlePainter = Paint()..color = handleColor;

    final handleBorderPainter = Paint()..color = selectedTrackColor;

    final leftPosition =
        ((value.start - min) * (size.width - sliderHandleRadius * 2) / (max - min)) +
            sliderHandleRadius;

    final rightPosition =
        ((value.end - min) * (size.width - sliderHandleRadius * 2) / (max - min)) +
            sliderHandleRadius;

    RangeValue handleCenterPositions = RangeValue(
      leftPosition,
      rightPosition,
    );

    if (divisions != null) {
      var divisionCoordinates = <double>[sliderHandleRadius];
      final step = (size.width - sliderHandleRadius * 2) / divisions!;
      var currentX = step;
      for (int i = 1; i < divisions!; i++) {
        divisionCoordinates.add(currentX + sliderHandleRadius);
        currentX += step;
      }
      divisionCoordinates.add(size.width - sliderHandleRadius);

      handleCenterPositions = RangeValue(
        divisionCoordinates.reduce(
          (a, b) =>
              (a - handleCenterPositions.start).abs() <= (b - handleCenterPositions.start).abs()
                  ? a
                  : b,
        ),
        divisionCoordinates.reduce(
          (a, b) => (a - handleCenterPositions.end).abs() <= (b - handleCenterPositions.end).abs()
              ? a
              : b,
        ),
      );
    }

    /// Minimal range between drawn handles. Does not depend on minimal range between values
    final minimalHandleRange = minimalHandleDrawingRange;
    final isCoordinatesOnMinimalRange =
        (handleCenterPositions.start - handleCenterPositions.end).abs() <= minimalHandleRange;

    if (isCoordinatesOnMinimalRange) {
      handleCenterPositions = RangeValue(
        leftIsAbove ? handleCenterPositions.end - minimalHandleRange : handleCenterPositions.start,
        leftIsAbove ? handleCenterPositions.end : handleCenterPositions.start + minimalHandleRange,
      );
    }

    _printHandleBorder(
      canvas,
      size,
      handleBorderPainter,
      leftIsAbove ? handleCenterPositions.end : handleCenterPositions.start,
    );
    _paintHandle(
      canvas,
      size,
      handlePainter,
      leftIsAbove ? handleCenterPositions.end : handleCenterPositions.start,
    );
    _printHandleBorder(
      canvas,
      size,
      handleBorderPainter,
      leftIsAbove ? handleCenterPositions.start : handleCenterPositions.end,
    );
    _paintHandle(
      canvas,
      size,
      handlePainter,
      leftIsAbove ? handleCenterPositions.start : handleCenterPositions.end,
    );
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
