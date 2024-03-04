import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Internal widget for displaying symbol in [CodeWidget].
class CodeSymbolWidget extends StatelessWidget {
  const CodeSymbolWidget({
    super.key,
    required this.size,
    required this.letter,
    required this.emptyColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.codeStyle,
  });

  /// Size of the widget. It is used to calculate the final height and width of the widget
  /// by multiplying it to the text scale.
  final double size;

  /// Symbol to display in widget, can be null
  final String? letter;

  /// Color of border for widget without symbol
  final Color? emptyColor;

  /// Color of background of Widget
  final Color? backgroundColor;

  /// Color of border for widget with symbol.
  final Color? borderColor;

  /// Widget border radius
  final BorderRadius borderRadius;

  /// Style for code symbol
  final TextStyle? codeStyle;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final scaledSize = MediaQuery.of(context).textScaler.scale(size);

    return AnimatedContainer(
      duration: _animationDuration,
      height: scaledSize,
      width: scaledSize,
      decoration: BoxDecoration(
        color: backgroundColor ??
            theme.colorPalette.greySwatch.backgroundColor ??
            theme.colorPalette.greySwatch.surfaceColor,
        borderRadius: borderRadius,
        border: Border.fromBorderSide(
          BorderSide(
            color: letter == null
                ? emptyColor ?? const Color(0x00000000)
                : borderColor ??
                    theme.colorPalette.tertiarySwatch?[400] ??
                    theme.colorPalette.tertiarySwatch ??
                    theme.colorPalette.primarySwatch,
          ),
        ),
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          style: (letter == null
                  ? codeStyle?.copyWith(
                        color: const Color(0x00000000),
                      ) ??
                      theme.typography?.subheading2Style?.copyWith(
                        color: const Color(0x00000000),
                      )
                  : codeStyle ??
                      theme.typography?.subheading2Style?.copyWith(
                        color: theme.colorPalette.greySwatch.onSurfaceBright,
                      )) ??
              const TextStyle(),
          duration: _animationDuration,
          child: Text(
            letter ?? '',
          ),
        ),
      ),
    );
  }
}
