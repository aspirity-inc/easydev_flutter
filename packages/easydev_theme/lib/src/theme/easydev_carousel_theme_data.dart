import 'package:flutter/painting.dart';

class EasyDevCarouselThemeData {
  const EasyDevCarouselThemeData({
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
    this.indicatorAnimationDuration,
  });

  final Color? selectedIndicatorColor;

  final Color? unselectedIndicatorColor;

  final Duration? indicatorAnimationDuration;

  @override
  bool operator ==(Object other) =>
      other is EasyDevCarouselThemeData &&
      selectedIndicatorColor == other.selectedIndicatorColor &&
      unselectedIndicatorColor == other.unselectedIndicatorColor &&
      indicatorAnimationDuration == other.indicatorAnimationDuration;

  @override
  int get hashCode => Object.hash(
        selectedIndicatorColor,
        unselectedIndicatorColor,
        indicatorAnimationDuration,
      );

  EasyDevCarouselThemeData copyWith({
    Color? selectedIndicatorColor,
    Color? unselectedIndicatorColor,
    Duration? indicatorAnimationDuration,
  }) =>
      EasyDevCarouselThemeData(
        selectedIndicatorColor: selectedIndicatorColor ?? this.selectedIndicatorColor,
        unselectedIndicatorColor: unselectedIndicatorColor ?? this.unselectedIndicatorColor,
        indicatorAnimationDuration: indicatorAnimationDuration ?? this.indicatorAnimationDuration,
      );
}
