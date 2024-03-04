import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// A customizable story simple content slider item. For contents using sources that
/// can be loaded synchronously. For example [Text], [AssetImage] etc.
class SimpleCustomSlideItem extends StatelessWidget {
  const SimpleCustomSlideItem({
    this.gradient,
    this.backgroundColor,
    this.text,
    this.textStyle,
    this.child,
    required this.width,
    required this.height,
    super.key,
  });

  /// Gradient color of the background of [SimpleCustomSlideItem].
  final Gradient? gradient;

  /// Color of the background of [SimpleCustomSlideItem].
  ///
  /// If defined together with [gradient], [gradient] will be used by default.
  /// Default value is 'surfaceColor'.
  final Color? backgroundColor;

  /// The text that is displayed at the bottom of [SimpleCustomSlideItem].
  ///
  /// If null then nothing is displayed
  final String? text;

  /// TextStyle of the [text].
  ///
  /// Default value is TextStyle with color value is onSurfaceColor.
  final TextStyle? textStyle;

  /// [SimpleCustomSlideItem] width.
  final double width;

  /// [SimpleCustomSlideItem] height.
  final double height;

  /// The widget that is displayed in the center of the [SimpleCustomSlideItem].
  ///
  /// If null then nothing is displayed
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    TextStyle textStyle = this.textStyle ??
        theme.typography?.subheading1Style?.copyWith(
          color: theme.colorPalette.greySwatch.onSurfaceColor,
        ) ??
        TextStyle(color: theme.colorPalette.greySwatch.onSurfaceColor);
    Color color = backgroundColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.dividerColor ?? theme.colorPalette.greySwatch.greyColor
            : theme.colorPalette.greySwatch.surfaceColor);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          child ?? const SizedBox.shrink(),
          text != null
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      text!,
                      style: textStyle,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
