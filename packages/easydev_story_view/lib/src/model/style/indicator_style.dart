import 'package:flutter/widgets.dart';

/// Story progress indicator styles.
class IndicatorStyle {
  /// Creates story progress indicator styles.
  const IndicatorStyle({
    this.horizontalPadding = 5.0,
    this.spacing = 8.0,
    this.backgroundColor,
    this.progressColor,
  });

  /// Space between starting of indicators and the left of the screen and
  /// right of the screen.
  ///
  /// Default value is 5.0.
  final double horizontalPadding;

  /// Space between indicators. This value is not affects padding between
  /// indicators and screen edges.
  ///
  /// Default value is 8.0.
  final double spacing;

  /// Color of active and filled indicators.
  final Color? progressColor;

  /// Empty indicator color.
  final Color? backgroundColor;
}
