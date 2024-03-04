import 'package:flutter/widgets.dart';

/// Used to draw a horizontal line below tabs.
class UnderlineTabIndicator extends Decoration {
  const UnderlineTabIndicator({
    required this.borderSide,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(1),
    ),
  });

  /// The radius of the indicator's corners.
  final BorderRadius borderRadius;

  /// The color and weight of the horizontal line drawn below tabs.
  final BorderSide borderSide;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(borderRadius, borderSide, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(
    this.borderRadius,
    this.borderSide,
    super.onChanged,
  );

  final BorderRadius borderRadius;
  final BorderSide borderSide;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = borderSide.color;

    final RRect indicator = RRect.fromRectAndCorners(
      Rect.fromLTRB(
        rect.left,
        rect.bottom - borderSide.width,
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
