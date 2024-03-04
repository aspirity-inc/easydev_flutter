import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for displaying [EasyDevSearchOption] in [EasyDevSearch].
class EasyDevSearchOptionListItem<T> extends StatefulWidget {
  const EasyDevSearchOptionListItem({
    super.key,
    required this.text,
    required this.value,
    required this.separatedElements,
    required this.onTap,
    this.highlight,
    this.color,
    this.tapColor,
    this.textStyle,
    this.tapTextStyle,
    this.highlightTextStyle,
  });

  final String text;

  final T value;

  final String? highlight;

  final Color? color;

  final Color? tapColor;

  final TextStyle? textStyle;

  final TextStyle? tapTextStyle;

  final TextStyle? highlightTextStyle;

  final bool separatedElements;

  final void Function(String value) onTap;

  @override
  State<EasyDevSearchOptionListItem> createState() => _EasyDevSearchOptionListItemState();
}

class _EasyDevSearchOptionListItemState extends State<EasyDevSearchOptionListItem> {
  bool isTapped = false;

  Color _getColor(EasyDevThemeData theme) {
    if (isTapped) {
      return widget.tapColor ??
          theme.colorPalette.secondarySwatch?[300] ??
          theme.brightness.surfaceColor;
    }
    if (theme.brightness == Brightness.light) {
      return widget.color ?? theme.colorPalette.greySwatch.surfaceColor;
    }
    return widget.color ??
        theme.colorPalette.greySwatch.disabledColor ??
        theme.brightness.surfaceColor;
  }

  TextStyle? _getTextStyle(EasyDevThemeData theme) {
    final textStyle = widget.textStyle ?? theme.typography?.body1Style;
    if (isTapped) {
      return widget.tapTextStyle ??
          textStyle?.copyWith(color: theme.colorPalette.greySwatch.surfaceColor);
    }
    return textStyle;
  }

  TextStyle? _getHighlightedTextStyle(EasyDevThemeData theme) {
    final textStyle = widget.highlightTextStyle ??
        theme.typography?.body1Style?.copyWith(
            color: theme.colorPalette.secondarySwatch?[400] ?? theme.brightness.onSurfaceColor);
    if (isTapped) {
      return widget.tapTextStyle ??
          textStyle?.copyWith(color: theme.colorPalette.greySwatch.surfaceColor);
    }
    return textStyle;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    final text = widget.highlight == null
        ? Text(widget.text, style: _getTextStyle(theme))
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.text.substring(0, widget.highlight?.length),
                  style: _getHighlightedTextStyle(theme),
                ),
                TextSpan(
                  text: widget.text.substring(widget.highlight!.length),
                  style: _getTextStyle(theme),
                ),
              ],
            ),
          );

    return GestureDetector(
      onTapDown: (details) {
        setState(() => isTapped = true);
      },
      onTapUp: (details) {
        widget.onTap(widget.text);
        setState(() => isTapped = false);
      },
      onTapCancel: () {
        setState(() => isTapped = false);
      },
      child: PhysicalShape(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: widget.separatedElements
                ? const BorderRadius.all(Radius.circular(8))
                : BorderRadius.zero,
          ),
        ),
        color: _getColor(theme),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: text,
        ),
      ),
    );
  }
}
