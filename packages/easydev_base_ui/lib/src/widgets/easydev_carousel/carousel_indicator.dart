import 'package:flutter/widgets.dart';

import 'page_indicator_type.dart';

/// Indicator for [EasyDevCarousel].
class CarouselIndicator extends StatelessWidget {
  /// Create indicator.
  const CarouselIndicator({
    super.key,
    required this.pageCount,
    required this.indicatorAnimationDuration,
    this.indicatorType = PageIndicatorType.colored,
    this.selectedPage,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
  });

  /// Number of pages of [EasyDevCarousel].
  final int pageCount;

  /// Index of the selected page.
  final int? selectedPage;

  /// Color of currently selected indicator.
  final Color? selectedIndicatorColor;

  /// Color of unselected indicators.
  final Color? unselectedIndicatorColor;

  /// Duration of indicator animation.
  final Duration indicatorAnimationDuration;

  /// Type of this indicator.
  final PageIndicatorType indicatorType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < pageCount; i++) ...[
          AnimatedContainer(
            height: 8,
            width: indicatorType == PageIndicatorType.expanded && i == selectedPage ? 24 : 8,
            duration: indicatorAnimationDuration,
            decoration: BoxDecoration(
              shape:
                  indicatorType == PageIndicatorType.colored ? BoxShape.circle : BoxShape.rectangle,
              borderRadius:
                  indicatorType == PageIndicatorType.expanded ? BorderRadius.circular(23) : null,
              color: i == selectedPage && indicatorType == PageIndicatorType.colored
                  ? selectedIndicatorColor
                  : unselectedIndicatorColor,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ],
    );
  }
}
