import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// {@macro flutter.rendering.custom_paint}
/// Internal [CustomPainter] for painting [EasyDevSlider] track.
class TrackPainter extends CustomPainter {
  const TrackPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.sliderTrackThickness,
    required this.sliderHandleRadius,
    required this.unselectedTrackColor,
    required this.selectedTrackColor,
    this.divisions,
  });

  final double value;
  final double min;
  final double max;
  final double sliderTrackThickness;
  final double sliderHandleRadius;
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
    final handleCenterPosition =
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

      final nearestCoordinate = divisionCoordinates.reduce(
        (a, b) => (a - handleCenterPosition).abs() <= (b - handleCenterPosition).abs() ? a : b,
      );
      _paintSelectedTrack(
        canvas,
        size,
        selectedTrackPaint,
        sliderTrackThickness,
        nearestCoordinate,
      );
      _paintDivisions(canvas, size, divisionCoordinates, handleCenterPosition);
    } else {
      _paintSelectedTrack(
        canvas,
        size,
        selectedTrackPaint,
        sliderTrackThickness,
        handleCenterPosition,
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
      Canvas canvas, Size size, Paint paint, double thickness, double position) {
    Path path = Path()
      ..moveTo(0, (size.height - thickness) / 2)
      ..lineTo(position, (size.height - thickness) / 2)
      ..lineTo(position, (size.height + thickness) / 2)
      ..lineTo(0, (size.height + thickness) / 2);

    canvas.drawPath(path, paint);
  }

  void _paintDivisions(
      Canvas canvas, Size size, List<double> divisionCoordinates, double position) {
    final selectedPaint = Paint()..color = selectedTrackColor;
    final notSelectedPaint = Paint()..color = unselectedTrackColor;
    canvas.drawCircle(
      Offset(2, size.height / 2),
      1,
      notSelectedPaint,
    );
    for (var i = 1; i < divisionCoordinates.length - 1; i++) {
      canvas.drawCircle(
        Offset(divisionCoordinates[i], size.height / 2),
        1,
        divisionCoordinates[i] > position ? selectedPaint : notSelectedPaint,
      );
    }
    canvas.drawCircle(
      Offset(size.width - 2, size.height / 2),
      1,
      selectedPaint,
    );
  }
}
