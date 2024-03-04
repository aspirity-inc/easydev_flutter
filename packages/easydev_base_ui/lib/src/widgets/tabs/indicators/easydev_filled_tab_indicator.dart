import 'package:flutter/widgets.dart';

/// Used to draw a filled indicator on the tab.
class FilledTabIndicator extends Decoration {
  const FilledTabIndicator({
    required this.color,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(1),
    ),
  });

  /// The radius of the indicator's corners.
  final BorderRadius borderRadius;

  /// The color of the indicator.
  final Color color;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FilledPainter(borderRadius, color, onChanged);
  }
}

class _FilledPainter extends BoxPainter {
  _FilledPainter(
      this.borderRadius,
      this.color,
      super.onChanged,
      );

  final BorderRadius borderRadius;
  final Color color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final RRect indicator = RRect.fromRectAndCorners(
      Rect.fromLTRB(
        rect.left,
        rect.top,
        rect.right,
        rect.bottom,
      ),
      topRight: borderRadius.topRight,
      topLeft: borderRadius.topLeft,
      bottomRight: borderRadius.bottomRight,
      bottomLeft: borderRadius.bottomLeft,
    );
    canvas.drawRRect(indicator, paint);
  }
}