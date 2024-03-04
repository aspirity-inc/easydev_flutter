import 'package:flutter/widgets.dart';

/// Styles for slider list.
class SliderStyle {
  /// Creates styles for slider.
  const SliderStyle({
    this.spacing = 8.0,
    this.padding = EdgeInsets.zero,
    this.viewedIndicatorColor,
    this.unwatchedIndicatorColor,
    this.indicatorWidth = 3.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  /// Space between slider items. This value is not affects padding between
  /// slider list and screen edges.
  ///
  /// Default value is 8.0.
  final double spacing;

  /// Space between tray list and parent widget.
  ///
  /// Default value is 'EdgeInsets.zero'.
  final EdgeInsets padding;

  /// Indicator color around the viewed story element in the slider.
  final Color? viewedIndicatorColor;

  /// Indicator color around the unwatched story element in the slider.
  final Color? unwatchedIndicatorColor;

  /// Width of indicator around the story element in the slider.
  ///
  /// Default value is 3.0.
  final double indicatorWidth;

  /// Radius of rounding the corners of indicator
  /// around the story element in the slider.
  ///
  /// Default value is 'BorderRadius.all(Radius.circular(16))'.
  final BorderRadius borderRadius;
}