import 'package:flutter/widgets.dart';

/// Decorator of shadows for elements of [StoryFooter]
class ShadowDecorator extends StatelessWidget {
  // Creates a shadow decorator
  const ShadowDecorator({
    super.key,
    required this.shadowColor,
    required this.offset,
    required this.blurRadius,
    required this.child,
  });

  /// Color that the shadow will be drawn with.
  final Color shadowColor;

  /// The displacement of the shadow from the casting element.
  final Offset offset;

  /// The standard deviation of the Gaussian to convolve with the shadow's shape.
  final double blurRadius;

  /// Inner widget of the decorator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: offset,
            blurRadius: blurRadius,
          )
        ],
      ),
      child: child,
    );
  }
}
