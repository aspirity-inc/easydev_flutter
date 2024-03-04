import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_story_view/src/model/style/indicator_style.dart';
import 'package:easydev_story_view/src/model/style/slider_style.dart';

import 'package:flutter/widgets.dart';

/// {@macro src/easydev_story.style}
class EasyDevStoryStyle {
  /// Creates styles to use in the [EasyDevStory].
  const EasyDevStoryStyle({
    this.indicatorStyle = const IndicatorStyle(),
    this.sliderStyle = const SliderStyle(),
    this.margin = const EdgeInsets.only(left: 16, right: 16, bottom: 20),
    this.closeButtonColor = const Color(0xffffffff),
    this.loadingScreen = const CircularLoadingIndicator(
      type: IndicatorType.medium,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  /// Story progress indicator style.
  ///
  /// Default value is 'IndicatorStyle'.
  final IndicatorStyle indicatorStyle;

  /// Custom loading screen widget.
  /// This is useful when you want to use your own loading screen.
  ///
  /// Default value is 'CircularLoadingIndicator.medium'.
  final Widget loadingScreen;

  /// Styles for slider list.
  ///
  /// Default value is 'SliderStyle'.
  final SliderStyle sliderStyle;

  /// Empty space around the story.
  ///
  /// Default value is 'EdgeInsets.only(left: 16, right: 16, bottom: 20)'.
  final EdgeInsetsGeometry margin;

  /// Color of close button.
  ///
  /// Default value is white 'Color(0xffffffff)'.
  final Color closeButtonColor;

  /// Radius of rounding the corners of indicator
  /// around the story element in the slider.
  ///
  /// Default value is 'BorderRadius.all(Radius.circular(8))'.
  final BorderRadius borderRadius;
}
