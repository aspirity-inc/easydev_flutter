import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// {@macro flutter.rendering.custom_paint}
/// Internal [CustomPainter] for painting [EasyDevRangeSlider] track.
class RangeTrackPainter extends CustomPainter {
  const RangeTrackPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.sliderTrackThickness,
    required this.sliderHandleRadius,
    required this.sliderHandleWidth,
    required this.handleColor,
    required this.unselectedTrackColor,
    required this.selectedTrackColor,
    this.divisions,
  });

  final RangeValue value;
  final double min;
  final double max;
  final double sliderTrackThickness;
  final double sliderHandleRadius;
  final double sliderHandleWidth;
  final Color handleColor;
  final Color unselectedTrackColor;
  final Color selectedTrackColor;
  final int? divisions;

  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()
      ..color = unselectedTrackColor
      ..strokeWidth = 1;

    final selectedTrackPaint = Paint()
      ..color = selectedTrackColor
      ..strokeWidth = 1;

    _paintTrack(canvas, size, trackPaint, sliderTrackThickness);
    final handleCenterPositions = RangeValue(
      ((value.start - min) * (size.width - sliderHandleRadius * 2) / (max - min)) +
          sliderHandleRadius,
      ((value.end - min) * (size.width - sliderHandleRadius * 2) / (max - min)) +
          sliderHandleRadius,
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

      final nearestCoordinates = RangeValue(
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

      _paintSelectedTrack(
        canvas,
        size,
        selectedTrackPaint,
        sliderTrackThickness,
        nearestCoordinates,
      );
      _paintDivisions(canvas, size, divisionCoordinates, handleCenterPositions);
    } else {
      _paintSelectedTrack(
        canvas,
        size,
        selectedTrackPaint,
        sliderTrackThickness,
        handleCenterPositions,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _paintTrack(Canvas canvas, Size size, Paint paint, double thickness) {
    Path path = Path()
      ..moveTo(thickness / 2, (size.height - thickness) / 2)
      ..lineTo(size.width - thickness, (size.height - thickness) / 2)
      ..arcTo(
        Rect.fromLTRB(
          size.width - thickness,
          (size.height - thickness) / 2,
          size.width,
          (size.height + thickness) / 2,
        ),
        3 * math.pi / 2,
        math.pi,
        false,
      )
      ..lineTo(thickness, (size.height + thickness) / 2)
      ..arcTo(
        Rect.fromLTRB(
          0,
          (size.height - thickness) / 2,
          thickness,
          (size.height + thickness) / 2,
        ),
        math.pi / 2,
        math.pi,
        false,
      );
    canvas
      ..drawPath(path, paint)
      ..clipPath(path);
  }

  void _paintSelectedTrack(
      Canvas canvas, Size size, Paint paint, double thickness, RangeValue positions) {
    Path path = Path()
      ..moveTo(positions.start, (size.height - thickness) / 2)
      ..lineTo(positions.end, (size.height - thickness) / 2)
      ..lineTo(positions.end, (size.height + thickness) / 2)
      ..lineTo(positions.start, (size.height + thickness) / 2);

    canvas.drawPath(path, paint);
  }

  void _paintDivisions(
      Canvas canvas, Size size, List<double> divisionCoordinates, RangeValue position) {
    final selectedPaint = Paint()..color = selectedTrackColor;
    final notSelectedPaint = Paint()..color = unselectedTrackColor;
    canvas.drawCircle(
      Offset(2, size.height / 2),
      1,
      selectedPaint,
    );
    for (var i = 1; i < divisionCoordinates.length - 1; i++) {
      canvas.drawCircle(
        Offset(divisionCoordinates[i], size.height / 2),
        1,
        divisionCoordinates[i] >= position.start && divisionCoordinates[i] <= position.end
            ? notSelectedPaint
            : selectedPaint,
      );
    }
    canvas.drawCircle(
      Offset(size.width - 2, size.height / 2),
      1,
      selectedPaint,
    );
  }
}
