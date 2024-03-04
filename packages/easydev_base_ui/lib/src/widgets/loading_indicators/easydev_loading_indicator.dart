import 'dart:math';

import 'package:easydev_base_ui/src/widgets/loading_indicators/delay_tween.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Circular loading indicator divided on descrete lines.
/// It is used for indicating ongoing tasks or processes.
///
/// [AnimationController] can be provided to [EasyDevLoadingIndicator] through [controller].
/// Other fields can be used for customizing [EasyDevLoadingIndicator].
///
///
/// Example of using [EasyDevLoadingIndicator].
/// ```dart
/// EasyDevLoadingIndicator(),
/// ```
///
///
/// This sample produces variant of EasyDevLoadingIndicator.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_loading_indicator_example.dart
class EasyDevLoadingIndicator extends StatefulWidget {
  /// Create loading indicator.
  const EasyDevLoadingIndicator({
    super.key,
    this.color,
    this.size = 24,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  });

  /// Color of this indicator.
  final Color? color;

  /// Controller for animation of this indicator.
  final AnimationController? controller;

  /// Diameter of this indicator.
  final double size;

  /// Duration that determines speed of this indicator.
  final Duration duration;

  @override
  State<EasyDevLoadingIndicator> createState() => _EasyDevLoadingIndicatorState();
}

class _EasyDevLoadingIndicatorState extends State<EasyDevLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(12, (index) {
            return Positioned(
              top: widget.size * 0.5,
              left: widget.size * 0.5,
              child: Transform(
                transform: Matrix4.rotationZ(30 * index * (pi / 180)),
                child: Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: DelayTween(
                      begin: 0.0,
                      end: 1.0,
                      delay: index / 12,
                    ).animate(_controller),
                    child: Container(
                      width: 2,
                      height: widget.size * 0.45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                            0.45,
                            0.45,
                          ],
                          colors: [
                            const Color(0x00FFFFFF),
                            widget.color ??
                                theme.colorPalette.tertiarySwatch?[200] ??
                                theme.colorPalette.tertiarySwatch ??
                                theme.colorPalette.primarySwatch,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          1,
                        ),
                        color: widget.color ??
                            theme.colorPalette.tertiarySwatch?[200] ??
                            theme.colorPalette.tertiarySwatch ??
                            theme.colorPalette.primarySwatch,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
