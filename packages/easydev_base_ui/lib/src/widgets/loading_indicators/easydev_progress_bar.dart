import 'package:easydev_base_ui/src/widgets/loading_indicators/progress_bar_painter.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Progress bar used to visualize completion status or progression of tasks.
/// The [percentage] parameter specifies the proportion of the progress bar that
/// should be filled, ranging from 0 to 1. Other fields can be used to customize [EasyDevProgressBar] appearence.
///
/// Example of using [EasyDevProgressBar].
/// ```dart
/// EasyDevProgressBar(
///   percentage: 0.5,
/// ),
/// ```
///
///
/// This sample produces variant of EasyDevProgressBar.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_progress_bar_example.dart
class EasyDevProgressBar extends StatelessWidget {
  /// Create progress bar.
  const EasyDevProgressBar({
    super.key,
    required this.percentage,
    this.color,
    this.progressColor,
    this.padding = const EdgeInsets.all(16),
  }) : assert(
          percentage >= 0 && percentage <= 1,
          'Percentage should be equal or more than zero and equal or less than one',
        );

  /// Color for empty part of progress bar.
  final Color? color;

  /// Color for part of progress bar that shows progress.
  final Color? progressColor;

  /// Percentage of indicator that must be filled with [progressColor].
  ///
  /// Must be between zero and one.
  final double percentage;

  /// Outer insets of progress bar.
  final EdgeInsets padding;

  Color _getColor(EasyDevThemeData theme) {
    final colorPalette = theme.colorPalette;
    Color? themeColor;
    if (theme.brightness == Brightness.dark) {
      themeColor = colorPalette.secondarySwatch?[300];
    } else {
      themeColor = colorPalette.secondarySwatch?[50];
    }
    return color ?? themeColor ?? colorPalette.secondarySwatch ?? colorPalette.greySwatch.greyColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final colorPalette = theme.colorPalette;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 8,
            margin: padding,
            child: CustomPaint(
              painter: ProgressBarPainter(
                _getColor(theme),
                progressColor ??
                    colorPalette.tertiarySwatch?[400] ??
                    colorPalette.tertiarySwatch ??
                    colorPalette.primarySwatch,
                percentage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
