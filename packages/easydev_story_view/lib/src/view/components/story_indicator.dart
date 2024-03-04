import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_story_view/src/model/style/indicator_style.dart';
import 'package:easydev_theme/easydev_theme.dart';

import 'package:flutter/widgets.dart';

/// Indicator view for the [EasyDevContentView]
class StoryIndicator extends StatelessWidget {
  /// Creates indicators for the every content in the story.
  ///
  /// Indicators before [activeIndicatorIndex] will be filled with
  /// [IndicatorStyle]' progressColor and the rest will be filled with
  /// with  backgroundColor.
  StoryIndicator({
    required this.count,
    required this.activeIndicatorIndex,
    required this.controller,
    required this.style,
    super.key,
  });

  // Blank story indicator used as initial indicator
  StoryIndicator.placeholder({
    required this.count,
    required this.style,
    super.key,
  })  : activeIndicatorIndex = -1,
        controller = null;

  /// Indicator progress controller.
  final AnimationController? controller;

  /// The number of indicators to display.
  final int count;

  /// Currently viewed story index. This index is filled with [IndicatorStyle]'s
  /// valueColor and animation is applied.
  final int activeIndicatorIndex;

  /// Style of the indicators.
  final IndicatorStyle style;

  /// Indicators to show.
  final List<Widget> _indicators = [];

  void _getIndicators(BuildContext context) {
    final theme = EasyDevTheme.of(context);
    Color progressColor = style.backgroundColor ??
        (theme.colorPalette.tertiarySwatch?[400]) ??
        theme.colorPalette.tertiarySwatch ??
        (theme.brightness == Brightness.light ? lightThemeLilac400 : darkThemeLilac400);

    Color backgroundColor = style.progressColor ?? theme.colorPalette.greySwatch.greyColor;

    final animation =
        controller != null ? Tween<double>(begin: 0.0, end: 1.0).animate(controller!) : null;
    if (_indicators.isNotEmpty) return;

    final indicators = List<Widget>.generate(
      count,
      (index) {
        final padding = (index != 0) ? EdgeInsets.only(left: style.spacing) : EdgeInsets.zero;
        if (index != activeIndicatorIndex) {
          final isBefore = index < activeIndicatorIndex;
          return Expanded(
            child: EasyDevProgressBar(
              color: backgroundColor,
              progressColor: progressColor,
              percentage: isBefore ? 1 : 0,
              padding: padding,
            ),
          );
        } else {
          return Expanded(
            child: AnimatedBuilder(
              animation: animation!,
              builder: (context, child) {
                return EasyDevProgressBar(
                  color: backgroundColor,
                  progressColor: progressColor,
                  percentage: animation.value,
                  padding: padding,
                );
              },
            ),
          );
        }
      },
    );
    _indicators.addAll(indicators);
  }

  @override
  Widget build(BuildContext context) {
    _getIndicators(context);
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: style.horizontalPadding,
          right: style.horizontalPadding,
          top: height * .05,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Row(children: _indicators),
        ),
      ),
    );
  }
}
