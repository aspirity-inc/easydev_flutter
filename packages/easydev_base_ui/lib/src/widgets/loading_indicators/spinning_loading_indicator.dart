import 'package:easydev_base_ui/src/widgets/loading_indicators/spinning_loading_indicator_painter.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Circular loading indicator divided on descrete lines.
/// It is used for indicating ongoing tasks or processes.
///
/// [AnimationController] can be provided to [SpinningLoadingIndicator] through [controller].
/// Other fields can be used for customizing [SpinningLoadingIndicator].
///
/// Same as [EasyDevLoadingIndicator] except for gradient.
///
///
/// Example of using [SpinningLoadingIndicator].
/// ```dart
/// SpinningLoadingIndicator(),
/// ```
///
///
/// This sample produces variant of SpinningLoadingIndicator.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_spinning_loading_indicator_example.dart
class SpinningLoadingIndicator extends StatefulWidget {
  const SpinningLoadingIndicator({
    super.key,
    this.color,
    this.size,
    this.controller,
    this.duration = const Duration(milliseconds: 1200),
  });

  /// Color of this indicator.
  final Color? color;

  /// Diameter of this indicator.
  final double? size;

  /// Controller for animation of this indicator.
  final AnimationController? controller;

  /// Duration that determines speed of this indicator.
  final Duration duration;

  @override
  State<SpinningLoadingIndicator> createState() => _SpinningLoadingIndicatorState();
}

class _SpinningLoadingIndicatorState extends State<SpinningLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: widget.duration,
        )
      ..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return RotationTransition(
      turns: _animation,
      child: Center(
        child: CustomPaint(
          size: Size.square(widget.size ?? 32),
          painter: SpinningLoadingIndicatorPainter(
            widget.color ??
                theme.colorPalette.tertiarySwatch?[200] ??
                theme.colorPalette.tertiarySwatch ??
                theme.colorPalette.primarySwatch,
          ),
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
