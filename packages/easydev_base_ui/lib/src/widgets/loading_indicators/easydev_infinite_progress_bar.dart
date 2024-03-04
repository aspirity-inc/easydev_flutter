import 'package:easydev_base_ui/src/widgets/loading_indicators/infinite_progress_bar_painter.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Infinite progress bar for indicating ongoing tasks or processes.
/// Its appearence can be customized with use of provided fields.
///
///
/// Example of using [EasyDevInfiniteProgressBar].
/// ```dart
/// EasyDevInfiniteProgressBar(
///   width: 202,
/// ),
/// ```
///
///
/// This sample produces variant of EasyDevInfiniteProgressBar.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_infinite_progress_bar_example.dart
class EasyDevInfiniteProgressBar extends StatefulWidget {
  /// Create infinite progress bar.
  const EasyDevInfiniteProgressBar({
    super.key,
    this.color,
    this.trackColor,
    this.padding = const EdgeInsets.all(16),
    this.width,
  });

  /// Color of the moving part of this indicator.
  final Color? color;

  /// Color of the track of this indicator.
  final Color? trackColor;

  /// Outer insets of this indicator.
  final EdgeInsets padding;

  /// Width of this indicator.
  final double? width;

  @override
  State<EasyDevInfiniteProgressBar> createState() => _EasyDevInfiniteProgressBarState();
}

class _EasyDevInfiniteProgressBarState extends State<EasyDevInfiniteProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
      upperBound: 1.5,
    )
      ..forward()
      ..addStatusListener(
        (status) async {
          if (status == AnimationStatus.completed) {
            await Future.delayed(
              const Duration(
                milliseconds: 1000,
              ),
            );
            if (mounted) {
              _controller.forward(from: 0);
            }
          }
        },
      );
  }

  Color _getColor(EasyDevThemeData theme) {
    final colorPalette = theme.colorPalette;
    final themeColor = colorPalette.tertiarySwatch?[400];
    return widget.color ??
        themeColor ??
        colorPalette.tertiarySwatch ??
        colorPalette.greySwatch.greyColor;
  }

  Color _getTrackColor(EasyDevThemeData theme) {
    final colorPalette = theme.colorPalette;
    final themeColor = colorPalette.secondarySwatch?[50];
    return widget.trackColor ??
        themeColor ??
        colorPalette.secondarySwatch ??
        colorPalette.greySwatch.greyColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return SizedBox(
      width: widget.width,
      child: AnimatedBuilder(
        animation: Tween<double>(begin: 0, end: 1.5).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        ),
        builder: (context, _) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 8,
                  margin: widget.padding,
                  child: CustomPaint(
                    painter: InfiniteProgressBarPainter(
                      _getColor(theme),
                      _getTrackColor(theme),
                      _controller.value,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
